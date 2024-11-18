Return-Path: <linux-fpga+bounces-933-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9989D095F
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Nov 2024 07:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158A61F2102E
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Nov 2024 06:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA99145B24;
	Mon, 18 Nov 2024 06:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S6dZ7R7h"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8FA13D24E;
	Mon, 18 Nov 2024 06:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731910270; cv=fail; b=n6dLIygeDrl1VooU02yzGYZdFhhnVgvwW2WV33UtgEVaB8Lg6H6tM5mB68lc5811YSV0dGUsNxhtA4XvVtLJiEqAUYrJEp0NJ4KMN6DYh7IdeRgSzhYbWq246JZXjsUaA6p3WDpDWKhqZbaBYfrI1lK++ZhNo18lCPfjAaRRCpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731910270; c=relaxed/simple;
	bh=Db8GuFxInuBUVTgF+2BkOqjXzzdUZs/nz99P1IBSF94=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VVb7QALbYiH2v5ERep+VauTtz7HfYpAFZXTBROG4oEn202e2XCSUS1pHYRS87QzVREIEGZXCn61p25I5Tpeq1pta+kkW+F+2NoLiHNpCBxhe7IvGTHDRfdboGnrO40edzcT0iRpeYif9hrj96UdmpyyAv7VDEflobsMqIuDRuwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S6dZ7R7h; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UX9bRHRJXvbbhdGOMcwp+V6c0CF8ZScs4MXlSCaVwTChqZZ3GJfnZKUSW9wiRoGVgifRRRfqJtwLqGBxjKRv7FdMSntWm4RINF4r3G4fHlbBrhMbcVyNZLO5tkLozlfndDvpedXFJEPUdREOLf1Qgnz0A3c3TD+nEqYrs789fW3HAOOMAYeLaNoQ6kiXnJR9P9TZ7QI44cQLYV62emP/NthoQeC6Vwc/VEcBzcclvrPvb3yNL0qSkFCfeq2TEA3z3EWOUrkDCEImNaxGVm3IgSD8sYAaDt5aKMzgdG3YHxLamlidvpUQY3IcNgah2iuOSnKPmwHPAXCPGFJ2A7tRXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Db8GuFxInuBUVTgF+2BkOqjXzzdUZs/nz99P1IBSF94=;
 b=X93dPtYtxzvhpPC6V26RDTIkg6wFi+Bp5NsHjenEMTGOgXxk8WUZ6BeWYxflSVwT6HF3zCGIt8dlbUb0aYVtisXopuzaftZTDgfx02ScAQZu4SMSbLr6C6v6HpHO1Wp5L7fEh9oYO2uqxIZYlIJpZfkzjAfhAdYblUuYD/Hnoy+SoC7thU6YxhV5HEVd2FTb+MEf5NtxNIwqKaaR5LluOxkZWQw6zsw7TdY4696WZs/B23QCFfgCV7rGLyUaHzftTKgDUeJEYZYmB1p9ibdo2uOGIIpaaIwCJP+uXEXHrH900he0y8cZ0Y5u1+XhGkZ2fdC3id1qyXR7Ie1SM+ezXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Db8GuFxInuBUVTgF+2BkOqjXzzdUZs/nz99P1IBSF94=;
 b=S6dZ7R7h/r/3BUveb0t7a33HuMeBRO4pJlpiJD3n9JA4sqwpSqrILNFItAkjPqstlBpOuCL13PqVQP43lRAmNeeIFLYGGAV0Xq4a0OUeQ18cu08eEJsTTIz95igf4yXK8m+n7Ius2vExYwmEZAsE5MMN/YQB6BLv/jsw13VwWN0=
Received: from DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) by
 IA0PR12MB7602.namprd12.prod.outlook.com (2603:10b6:208:43a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Mon, 18 Nov
 2024 06:11:01 +0000
Received: from DS7PR12MB6070.namprd12.prod.outlook.com
 ([fe80::b847:e013:8f93:f6e4]) by DS7PR12MB6070.namprd12.prod.outlook.com
 ([fe80::b847:e013:8f93:f6e4%5]) with mapi id 15.20.8158.019; Mon, 18 Nov 2024
 06:11:01 +0000
From: "Manne, Nava kishore" <nava.kishore.manne@amd.com>
To: "git (AMD-Xilinx)" <git@amd.com>, "mdf@kernel.org" <mdf@kernel.org>,
	"hao.wu@intel.com" <hao.wu@intel.com>, "yilun.xu@intel.com"
	<yilun.xu@intel.com>, "trix@redhat.com" <trix@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "saravanak@google.com" <saravanak@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [RFC v2 0/1]Add user space interaction for FPGA programming
Thread-Topic: [RFC v2 0/1]Add user space interaction for FPGA programming
Thread-Index: AQHbKeNqeNR6Dho250ufzzShdO4TPLK8rVIw
Date: Mon, 18 Nov 2024 06:11:01 +0000
Message-ID:
 <DS7PR12MB60701E2A3B87BAD211CAD9AFCD272@DS7PR12MB6070.namprd12.prod.outlook.com>
References: <20241029091734.3288005-1-nava.kishore.manne@amd.com>
In-Reply-To: <20241029091734.3288005-1-nava.kishore.manne@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6070:EE_|IA0PR12MB7602:EE_
x-ms-office365-filtering-correlation-id: fa4f1cb2-1347-4ced-d5bf-08dd0797c6d0
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?d0U2NGRuQ0VaczlaWXNSelJveUJMcy9ud2szemZnUnBsbUJaRS94c2l5RU9O?=
 =?utf-8?B?ZDJPWEg1REliVENpSmJWR0lvL0NjN0ZFV1hjMzVzaThFTTNMcVZsVGRwcTNy?=
 =?utf-8?B?bWJ1YWNGTURRb2xKK3kwWnc1Yk5KWXd0MVdtSUVnYWJVbEQzeVNtLzUrTjB2?=
 =?utf-8?B?bDFGeGJ5bXU0UStSLzJ5MXVHTVpZeFJXSHhZbGZuYWUvWkw0L1NESU1nR2Q3?=
 =?utf-8?B?aVd2bWE0VVF1TUVad2JpdEplRDVjY1pxVkw4Q2RNV2M1VWtwZjUxTm9CL0hw?=
 =?utf-8?B?K2tranQ0aFZ0eEhEdTdDZlJtaGdNUUtqamc3M3hyd2g4cGw1Z2tFc3JBRTlr?=
 =?utf-8?B?OG5nZi8rR05PVGFiQ3pRYWgzSTFLZFpUbkhiTzYrOERnbU5EbWtud21MV2ds?=
 =?utf-8?B?UkhGTUd5NVNPMFZDN1V4RGJLZEVLOUhzYjNWWVZSK2FlMjgzUnVaT1lNVjVs?=
 =?utf-8?B?RDlNdEV0S3BsMmF1WDRjVDcweERYSURsN0NWTkZrUkluMFp4NUZhUXV1cTAy?=
 =?utf-8?B?TXA0OEFOV3F1Y1VjaHFaN25kV2VRUXUzdmNhOFlvUE9CZzVycGJHVnM3N1FH?=
 =?utf-8?B?Uit1WjJrNDlkNUdBNFZhVmYweVhtRllhRWFIVGNHWHJidVk3S1ZaSFgxWVpJ?=
 =?utf-8?B?VHpzTDlmdDNzYnkvdW5LQ3p4ZHl0aEtNakIzcXpneEhXY2xhNWE5dEhmdHk4?=
 =?utf-8?B?dFpOVWRITjhxdHZPS3ZwVnR5eURxR2VEdEpoV3JlWEVOZ2d6aHcrazhhOSs5?=
 =?utf-8?B?VU1lYjN4T0RyMXc2SkJWbktJdExvRTdMM05pMlJZbzF2NVI4NDlYVTZMSzVQ?=
 =?utf-8?B?OUY3WVpnZTY4b3QvOG5XajlBNUJJd2dvZ2d1S1kxSWVsZ2U1TldtREhpVXBD?=
 =?utf-8?B?U0VEdlpNeVlkRm5zc2NXOVlHQlQwUisxWGtJV014bW1Ga0o1V05tTzRkbkIz?=
 =?utf-8?B?elY1UGlvN2JONFJLOXVVSEh4RE43QUpHSkRIYStSYnJpY2oyVGhFbW5zamVH?=
 =?utf-8?B?SHFGQXNHa1YzYlEvcnRCUEw3UXNRMW9WWXE5WWxYanJtbVR6TjBJdlY0NE9y?=
 =?utf-8?B?MWkxdEpQYTVoS2h6OUxJQ2RtdW9KTUgzU1Q2U3hMZFg1Z2J1bDQ3YStnd045?=
 =?utf-8?B?cHRaWHQxSjhqaUQvc253VVpRTnQwTEZidTRaQnRPMVk3MU1VVlNKbWw3Yml1?=
 =?utf-8?B?V0N4NEV5dFBGR3F1TkVJejNrZ3daUkZ0ekxOVEZOTHBTeHh4TnEvaVRuQ3V1?=
 =?utf-8?B?YWtVR0xLQVpCOGordTBMRUdlU01iNnRRQ2lpTlNwMkJJby9sNmhEQ2t1dnA4?=
 =?utf-8?B?NWZNdzJYbGIyUUZFVGxCUkFwRmtvbUFZdklHb3FCbFFUaVZxMFQ5M0dCRjVI?=
 =?utf-8?B?Y2JmcnF0NVM1eWlTU0RsM085MENLNVBmT3ZGcitBUVdsZ0JYTStxdjNnQlEx?=
 =?utf-8?B?SzJpbU10L1hnME9ycGNtUlVvZHFzUUNMc3pGOERMY2hVUGVhZHl2WHVoWHVZ?=
 =?utf-8?B?UVNOeVRRdGZTaHlMNEVHYzcwdGhtUUlRbDhlbExlS0RkSXR3WGlwN3Jsa1di?=
 =?utf-8?B?NmM0NHhUNmRqVnVsM0JHWVhOTHpyeWlBUEkrMjJvZUdiYTlRNnZicURxd3ZE?=
 =?utf-8?B?RkNuNXZ6OGJxcjdZRHBORWlTbFl5REFxRmxJa2JoUFVuUjlQcVhzbVE0VVZm?=
 =?utf-8?B?SCtmK0JFWkZSeG5yaUJXUU9DcjZ2R3J3bWdicGtQUnhXRzF3eGpDK3pwNmtF?=
 =?utf-8?B?UWpEL2ZRTzVEYUdENnJnQ1N6TS9MemxlU1pKNDJwQTdRTUpsajBpZVNNdi9n?=
 =?utf-8?B?THIxeldMTVR0aFdNNC9DREtjTHduaSs2QlRVV2pycElCQXZIY3dBYytEbXB4?=
 =?utf-8?Q?KDAE/B69+8B4W?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OThhNlBHK040Ukt3d3pHdGtzUFVJV0RXYndSNUw1YjU1MGtIcVg3Qkd6T0Jk?=
 =?utf-8?B?WXk2NEsvRjRrL0hISkp2M09VK0VHV3JxR0tkSVR0M3NNeWZEWnNkS001d3pM?=
 =?utf-8?B?cllMcFMrbUY4My8xelZUMEwvM1JjUXk5WGZadHpqeVRsWHQwNXo4MlNCU2I4?=
 =?utf-8?B?d2R2M1BoKys4S3RHQ0dTOVdPNVd1M3MvN21tTTZWallLN255dlNXdmNPZTBz?=
 =?utf-8?B?d0p6TWdmNFBkVFpySndTRmFlcmFmcTQ3bzREU1NnZDhDRjlKZmEvWlFlL3Bn?=
 =?utf-8?B?WlhFRXhSUHhKVmlWeFhzclFKb2RWR0Zqc05oQTJackFQZFVTZ2JxSnVDeHU2?=
 =?utf-8?B?SjhzckR0UzZjRUlIdXpYOFdSZEZzbGRUQVQvN08rbHl2ZTRIaTkzU0ZEU3Ez?=
 =?utf-8?B?OC81ajFFa0hoQUZSSTVYSzQ5MjF6SzF3cjRRc2pTNkhKeHZCSTJOcjFlNnNN?=
 =?utf-8?B?NzdRaW9BWC9nSkxkNTIrRXEyYUcvbjJIbzAweWVMeldLWUwwK1ViNVV3SUpl?=
 =?utf-8?B?Yk55WTZIYmlpeVdsR3pGYjZxTEc5R1J2Z0hwdWJvSmJhc0VKelFoUEpIa0dx?=
 =?utf-8?B?WExOZDYrVmRDajNJMS9WNzRyR0RyeVlLbkRCSDgvUFB6VnNQNnB1UDlwUU9O?=
 =?utf-8?B?SXI0QnVTdzY0am5pMjNqYmJyS1VKUUN1U0ZGUDlHUDZoRnErTlRXemoxemt4?=
 =?utf-8?B?cS8zazhDVFkwK08yV1NteWoyNDhLMFNEMHZubThCenorWm1qcDB3ZjVtd3Zl?=
 =?utf-8?B?YTZRUnBURUVkdTNGZVpYcEVaa3BkV28rUm9SNUR2RW51TkxiUE9LVHg2ZVZh?=
 =?utf-8?B?TUkyVGYyckN3Mk9uNytQUGRpOVhuQ3BxT2VMUGJUMGErOFVqdFR4OGpORUh2?=
 =?utf-8?B?d2JrcU9MZWZMN2Q5NjFsTlY4U1NQVVpOZWR4bzh2U0NOT2NGeFFFdWFGaVFa?=
 =?utf-8?B?TnJzNHRERDJNZlVjOHExYzZFbmZFMlBVaFNOTVlHSGNEbW14cWphRkdMS2dH?=
 =?utf-8?B?ZFJ5b0h1Vmo1a1M2MFBGYTBCTzI4aDZZWUZQUmxkRkVaNWhzU3lxcWVRN2x5?=
 =?utf-8?B?Z2Z1TnQ5UjRROE1SenI1cHlOR09kYUx3UzFNd0dKR3VkTmNobWVxZGZvcmli?=
 =?utf-8?B?S2wwUEt5N1VZZmNBT0JuV3RNL3BQK3Q1YlYvclpWREpPRkkzazhGRFBtUHNj?=
 =?utf-8?B?ZEpMWHpJdUJ4d0F6aWdkcXQydDRBbTI0eXF3a0NLRTNoMjN2WGlXdnphK3NR?=
 =?utf-8?B?b203MXRVMXF4MEdHVk43T29qNVdGb29YWW0xRmJ0T3pMVkZqSG4wVDVCcVYr?=
 =?utf-8?B?U0lkM21pb3hpdHNadGxzSllJM1VsaXppY082T0F5YzBrall6WGt6SngvU2t3?=
 =?utf-8?B?c2V3Q1NEOXhiV0djaitLODk1RnJVc1g1RldlK2tPTkp5empRYmh5OVJiVFRX?=
 =?utf-8?B?OFhCRFFQeWt2SFNVZ3poT1hIMnBUWkNRWXFnVFJ0ODd0M1JrM3RhbHY4YmQ2?=
 =?utf-8?B?U0szdzUwZzJyZDZpRWZKQ0F6MTVUR1NwUXMvdU5tYkFOaVc5anZXNkw2MHl4?=
 =?utf-8?B?YnhGdmV6K2JCcVd5SDJIdWllYTAyNkd3YWJzUk1hYWIzRlpod0pJbG1wME0v?=
 =?utf-8?B?WE04cFRlclRaWkI0UFVOYVhxeFFHZDRSR3o3cWpOUnBQdkwzZGJSeTNuQkUw?=
 =?utf-8?B?WCsrSlJQc1ZCSEpzZDczeDFYS0FzK2pHZjZGbXEzalZGeExFSStKa2NCTCt1?=
 =?utf-8?B?T0QvRGlYZ2RDSWh6RzV4RVQxWG5jRFUzNmR1UVJuTmpRTkp4Wk5tTXZua3BH?=
 =?utf-8?B?dXhVK1pYZ2FsRE1DVktXdUxkK2NxbWFnU2RGczZqaXBGSmk1d3loSjBWN2Ro?=
 =?utf-8?B?d1B6ZnArL205U2dGdXJKVlRnWFRQWDRkMU9qeGVwT3lZeXRXRkFabC82eit6?=
 =?utf-8?B?NVBSK2kzdGpBWGh6NTN0TFUvd3d2RHVpYU9FdjhmaHFaNHQyb2xNWEIzY3ho?=
 =?utf-8?B?b2UwK3FwNHMwY2xGNy9OSmRSM1U3RGFyamowbG9VYWtTU2JIOE5qdDh6NHlk?=
 =?utf-8?B?cjFDYW1hdTBFNFlhWVV2T2h4RWpkWWVhYzNNNmR1ek9QZHdkOFhHakVuM3Na?=
 =?utf-8?Q?ifwc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4f1cb2-1347-4ced-d5bf-08dd0797c6d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 06:11:01.3397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d1W0YJvvl8fMdSygH4Ls2j5V3aMrnnrPff9bS36Tc6EyScstgpBBrNq287Atp+Jv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7602

UGluZyENCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5uZSwgTmF2
YSBraXNob3JlIDxuYXZhLmtpc2hvcmUubWFubmVAYW1kLmNvbT4NCj4gU2VudDogVHVlc2RheSwg
T2N0b2JlciAyOSwgMjAyNCAyOjQ4IFBNDQo+IFRvOiBnaXQgKEFNRC1YaWxpbngpIDxnaXRAYW1k
LmNvbT47IG1kZkBrZXJuZWwub3JnOyBoYW8ud3VAaW50ZWwuY29tOw0KPiB5aWx1bi54dUBpbnRl
bC5jb207IHRyaXhAcmVkaGF0LmNvbTsgcm9iaEBrZXJuZWwub3JnOyBzYXJhdmFuYWtAZ29vZ2xl
LmNvbTsNCj4gTWFubmUsIE5hdmEga2lzaG9yZSA8bmF2YS5raXNob3JlLm1hbm5lQGFtZC5jb20+
OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtZnBnYUB2Z2VyLmtlcm5l
bC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtSRkMgdjIgMC8x
XUFkZCB1c2VyIHNwYWNlIGludGVyYWN0aW9uIGZvciBGUEdBIHByb2dyYW1taW5nDQo+IA0KPiBU
aGUgZXhpc3RpbmcgRlBHQSBtYW5hZ2VyIHN1YnN5c3RlbSBkaWRuJ3QgaGF2ZSBhbnkgdXNlciBz
cGFjZSBpbnRlcmZhY2UgKG90aGVyDQo+IHRoYW4gdGhlIHN0YXR1cy9zdGF0ZSBpbiBzeXNmcykg
aW4gS2VybmVsLiBCYXNpY2FsbHksIEZQR0FzIGFyZSBzZW1pY29uZHVjdG9yDQo+IGRldmljZXMg
dGhhdCBjYW4gYmUgcmVwcm9ncmFtbWVkIGZvciBkZXNpcmVkIGhhcmR3YXJlIGZ1bmN0aW9uYWxp
dHkuDQo+IA0KPiBGUEdBcyBjYW4gYmUgcmVwcm9ncmFtbWVkIGF0IHJ1bnRpbWUgd2l0aCBkaWZm
ZXJlbnQgdHlwZXMgb2YgbG9naWMgYW5kIElQcyBhcyBwZXINCj4gdXNlciBuZWVkIGFuZCBoZW5j
ZSB0aGVyZSBpcyBhIG5lZWQgdG8gdXNlIGRldmljZSB0cmVlIG92ZXJsYXlzIGZvcg0KPiByZW1v
dmluZy91cGRhdGluZy9hZGRpbmcgdGhlIGRldmljZXMgYXQgcnVudGltZSBmb3IgdGhlIElQcy9j
b250cm9sbGVycyB0aGF0IGFyZQ0KPiBwcmVzZW50IGluIEZQR0EuIEJ1dCB3ZSBkb24ndCBoYXZl
IGFueSB1c2VyIGludGVyZmFjZSBpbiBrZXJuZWwgZm9yIHVwZGF0aW5nIHRoZQ0KPiBkZXZpY2Ug
dHJlZSBhdCBydW50aW1lLg0KPiANCj4gU29tZXRpbWUgYmFjayB0aGVyZSB3YXMgYSBzZXJpZXMg
c2VudCBieSBQYW50ZWxpcyBBbnRvbmlvdQ0KPiAoaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGtt
bC8xNDE0NTI4NTY1LTEwOTA3LTQtZ2l0LXNlbmQtZW1haWwtDQo+IHBhbnRlbGlzLmFudG9uaW91
QGtvbnN1bGtvLmNvbS8pLg0KPiANCj4gVGhpcyBwYXRjaCBpbnRyb2R1Y2VkIGEgdXNlciBpbnRl
cmZhY2UgY29uZmlnZnMgZm9yIERldmljZSBUcmVlIG92ZXJsYXlzLCBhIG1ldGhvZCBvZg0KPiBk
eW5hbWljYWxseSBhbHRlcmluZyB0aGUga2VybmVsJ3MgbGl2ZSBEZXZpY2UgVHJlZS4gSG93ZXZl
ciwgdGhpcyBwYXRjaCBzZXJpZXMgd2FzDQo+IG5vdCBhY2NlcHRlZCBpbiBtYWlubGluZSBkdWUg
dG8gdmFyaW91cyBjb25jZXJucy4NCj4gRm9yIG1vcmUgZGV0YWlscyByZWZlciB0byB0aGlzIGxp
bms6DQo+IGh0dHBzOi8vZWxpbnV4Lm9yZy9GcmFuayUyN3NfRXZvbHZpbmdfT3ZlcmxheV9UaG91
Z2h0cyNpc3N1ZXNfYW5kX3doYXRfbmVlZHMNCj4gX3RvX2JlX2NvbXBsZXRlZF8tLV9Ob3RfYW5f
ZXhoYXVzdGl2ZV9saXN0DQo+IA0KPiBPbmUgb2YgdGhlIG1ham9yIHZhbGlkIGNvbmNlcm5zIHRo
YXQgd2VyZSByYWlzZWQgd2l0aCB0aGlzIGNvbmZpZ2ZzIGludGVyZmFjZSB3YXMNCj4gc2VjdXJp
dHkuIEl0IHByb3ZpZGVzIGEgZ2VuZXJpYyBpbnRlcmZhY2UgKE5vdCBzcGVjaWZpYyB0byB0aGUg
dXNlIGNhc2VzKSBmb3IgbW9kaWZ5aW5nDQo+IHRoZSBsaXZlIGRldmljZSB0cmVlLg0KPiANCj4g
SW4gb3JkZXIgdG8gY29uZmlndXJlL3Byb2dyYW0gdGhlIEZQR0EgZGV2aWNlcywgQWxsIHRoZSBt
YWpvciB2ZW5kb3JzIG9mIEZQR0EgYXJlDQo+IHVzaW5nIHRoaXMgY29uZmlnZnMgc2VyaWVzIGFz
IG91dC1vZi10cmVlIHBhdGNoIGZvciBjb25maWd1cmluZyB0aGUgRlBHQXMgYW5kIHRoZXJlDQo+
IHdhcyBuZXZlciBhbiBhdHRlbXB0IHRvIGludHJvZHVjZSBhIGdlbmVyaWMgaW50ZXJmYWNlIHRv
IGNvbmZpZ3VyZS9wcm9ncmFtIHRoZQ0KPiBGUEdBIGluIHVwc3RyZWFtIGFuZCBoZW5jZSB1cHN0
cmVhbSBrZXJuZWwgZW5kZWQgdXAgaW4gbm90IGhhdmluZyBwcm9wZXINCj4gc3VwcG9ydCBmb3Ig
RlBHQXMgY29uZmlndXJlL3Byb2dyYW0uDQo+IFRoaXMgc2VyaWVzIHRyaWVzIHRvIGFkZHJlc3Mg
dGhpcyBnYXAgb2YgRlBHQSBwcm9ncmFtbWFiaWxpdHkgYnkgcHJvdmlkaW5nIGEgbmV3DQo+IElP
Q1RMIGludGVyZmFjZSB0byB0aGUgdXNlci4NCj4gDQo+IFRoZSBuZXdseSBpbnRyb2R1Y2VkIElP
Q1RMIGludGVyZmFjZSBvZmZlcnMgYSBnZW5lcmljIGFuZCBzdGFuZGFyZGl6ZWQgbWVjaGFuaXNt
DQo+IGZvciBjb25maWd1cmluZyBvciByZXByb2dyYW1taW5nIEZQR0FzIGF0IHJ1bnRpbWUuIEl0
IHN1cHBvcnRzIGJvdGggT3BlbiBGaXJtd2FyZQ0KPiAoT0YpIGFuZCBub24tT0YgZGV2aWNlcywg
dXRpbGl6aW5nIHZlbmRvci1zcGVjaWZpYyBjYWxsYmFja3PigJRzdWNoIGFzDQo+IGNvbmZpZ3Vy
YXRpb24rZW51bWVyYXRpb24sIHJlbW92YWwsIGFuZCBzdGF0dXMgY2hlY2tzLg0KPiBUbyBhY2Nv
bW1vZGF0ZSBkaXZlcnNlIGRldmljZS1zcGVjaWZpYyBjb25maWd1cmF0aW9ucy4NCj4gDQo+IFRo
aXMgc29sdXRpb24gZW5oYW5jZXMgRlBHQSBydW50aW1lIG1hbmFnZW1lbnQsIHN1cHBvcnRpbmcg
dmFyaW91cyBkZXZpY2UgdHlwZXMNCj4gYW5kIHZlbmRvcnMsIHdoaWxlIGVuc3VyaW5nIGNvbXBh
dGliaWxpdHkgd2l0aCB0aGUgY3VycmVudCBGUEdBIGNvbmZpZ3VyYXRpb24gZmxvdy4NCj4gDQo+
IE5hdmEga2lzaG9yZSBNYW5uZSAoMSk6DQo+ICAgZnBnYS1yZWdpb246IEFkZCBnZW5lcmljIElP
Q1RMIGludGVyZmFjZSBmb3IgcnVudGltZSBGUEdBIHByb2dyYW1taW5nDQo+IA0KPiAgZHJpdmVy
cy9mcGdhL2ZwZ2EtcmVnaW9uLmMgICAgICAgfCAxMTAgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPiAgZHJpdmVycy9mcGdhL29mLWZwZ2EtcmVnaW9uLmMgICAgfCAgOTEgKysrKysr
KysrKysrKysrKysrKysrKysrLQ0KPiAgaW5jbHVkZS9saW51eC9mcGdhL2ZwZ2EtcmVnaW9uLmgg
fCAgMzIgKysrKysrKysrICBpbmNsdWRlL3VhcGkvbGludXgvZnBnYS1yZWdpb24uaCB8DQo+IDUx
ICsrKysrKysrKysrKysrDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDI4MyBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gaW5jbHVkZS91YXBpL2xpbnV4L2Zw
Z2EtcmVnaW9uLmgNCj4gDQo+IC0tDQo+IDIuMzQuMQ0KDQo=

