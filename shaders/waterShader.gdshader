shader_type canvas_item;
uniform vec2 size;
uniform vec2 as;

float snap(float x,float n){
	return floor(x/n)*n;
}
float centeredSnap(float x,float n){
	return round(x/n)*n;
}
float lineClosenessTexture(vec2 position,float n,float m,float p){
	float distLineX = 2.0*abs(position.x-centeredSnap(position.x,n))/n;
	float distLineY = 2.0*abs(position.y-centeredSnap(position.y,m))/m;
	return pow(distLineX,p)+ pow(distLineY,p);
}

float seudoRandom(float a, float b){
	float normalizedNoise =(sin(TIME*10.0+0.6)
						   +sin(TIME*11.0+0.7)
						   +sin(TIME*12.0+0.8))/3.0;
	return normalizedNoise*(b-a) +a;
}
vec4 getMovingWaterTexture(vec2 location, float scale,sampler2D tex){
	vec2 sampleLocation1 = scale*(location + 77.0 + TIME * vec2(0.02,0.01));
	vec2 sampleLocation2 = scale*(location + TIME * vec2(0.01,0.007));
	return max(texture(tex,sampleLocation1),1.0-texture(tex,sampleLocation2));
}

void fragment() {
	vec4 waterTex =getMovingWaterTexture(UV,0.2,TEXTURE);
	float waterMap = waterTex.x;
	float lineMapTail = lineClosenessTexture(UV*size,100.0,100.0,10.0);
	float lineMapHighlight = lineClosenessTexture(UV*size,100.0,100.0,40.0)*2.0;
	float lineMapFlashes = lineClosenessTexture(UV*size,100.0,100.0,10.0)*20.0;
	
	float lineSmallLines = lineClosenessTexture(UV*size+waterTex.xy*60.0,27.0,27.0,5.0);
 COLOR=  vec4( (lineMapTail) * vec3(0.0,0.0,0.5)
				+ (lineMapHighlight) * vec3(1.0,1.0,1.0)
				+ (lineMapFlashes * pow(waterMap,6.0)*10.0) * vec3(0.0,0.2,0.2)
				+ (lineSmallLines) * vec3(0.0,0.0,0.1)
				+ vec3(0.0,0.07,0.1)
				,1.0);
	//float movingLines = lineClosenessTexture(UV*size+waterTex.xy*60.0,100.0,100.0,40.0)*2.0;
	//COLOR=  vec4( movingLines * vec3(1.0,1.0,1.0),1.0);
	//COLOR=  vec4( vec3(1.0,1.0,1.0) * pow(waterMap,6.0)*10.0,1.0);
	//COLOR=  vec4( vec3(1.0,1.0,1.0) *lineMapHighlight,1.0);
}