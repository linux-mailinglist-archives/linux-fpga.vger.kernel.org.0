Return-Path: <linux-fpga+bounces-1445-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F7DC501E4
	for <lists+linux-fpga@lfdr.de>; Wed, 12 Nov 2025 01:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8123AEF6F
	for <lists+linux-fpga@lfdr.de>; Wed, 12 Nov 2025 00:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E621A23A4;
	Wed, 12 Nov 2025 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="RXarWE14"
X-Original-To: linux-fpga@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010008.outbound.protection.outlook.com [52.101.61.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606C614A9B;
	Wed, 12 Nov 2025 00:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762906798; cv=fail; b=W+N+Qs4UgN+LQ+IJyvSACStUHaEkVvMd7etrLYGaXdyrKxa342EswaOZRDf+mvbgycFWb1MveJu9g512qk+fROuJZLqDyMbiXKOfNAPp2Eto4T4M404Ie0PAum4bVeaM8SpOl4cGIiTzwb7rUYbvr1SQFiKPkqZNycu1IVgrXe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762906798; c=relaxed/simple;
	bh=8hv7evf0bDbv24nydTkDeaG6JSTZaIZmHZVV69yjC+s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uTxoThPiTYfKjaeMMvQTRVd5iZoGXRkd6+NtMhxbXpKpy/bdq+NFGMZFGLj0Rzch3ojADrn/tdJfbfRgEEpmRNL21w/DgFke3i2NVvVaj9FwqXe/Pm5+ScG6pW8EP1qlsU3WL9q0Pu+SefF0AkbxBOx1vZx9T+Mmk1OwLOVJqHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=RXarWE14; arc=fail smtp.client-ip=52.101.61.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxETPmLukb6fX7RZ0ESgDqwK/F1vzrBIE6PFbQpDk+dMkwY1IgnDO7l9M80F93LRxVz5wwmkAlLSL0yim3TsNU6JCtNy4TTMYdAjvsnwIHhnXyYhXtvAsnLUcHVCG1AZ4ipEOhpGur5uTt0C4eC7FSvbCYwqvVPvpBO5zwR6vQR4+s+d1vVjsz8uY/kV59xFNTEDig1Qq2AoblLdqdOEdTXv1LDNg88eyrvX8Gqs5d4qKPLo/FeChW0jivUT7XQzTIdJzYfO/M5nnFNq2PCmCLtocXbkwCIE8lNGVBS3byaNke5d8WUejvfynoz78WmV1i4LZVQ343EpmUWkOf+0Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hv7evf0bDbv24nydTkDeaG6JSTZaIZmHZVV69yjC+s=;
 b=ZeNW/e3Cm6ICJVSPdsEWjJCNEBdf5o2+gN1OxopTZtc/q69mTnCTOPMEtdcuE7dREkMefj4yDb6HeP+dz4VuXEhOiqkzQI4Qs0w+8CpMtE95raaGx3Q0SiQbKybIxD8fB7Y2SDWJzz/qgSL32sO4GOnKFSODG4IPubBa5B4JE+PklryTNa0nwccfaIaZVFum8jOQxheJtQE2iwMWisyyiJD65+MeYXHeC/GIJW8Q4MM10G1eC8a1by/5f5CNNC1z8NkoopPxlKqVhcLZjwziwlMwfbuC/v+igFw5H81D19x/VWRwOz+XxuVFkq06DeTXZVi30rRKu0uKRxEXxQIr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hv7evf0bDbv24nydTkDeaG6JSTZaIZmHZVV69yjC+s=;
 b=RXarWE14+097VdMkJjWiJzdAQCiEXIpkWVkcbRbDOMfF1F6Q6ONTwcoAXLRz+MvDoeXoDYRfYQ4sXG0INgtoynDJoIpFgb+65T4t/UIRva4AqZZ0xt+fpQZHDTTAbL1rysKw1vuUFLGHSTM8tlTIlXciXPWONXxmtiBNnVoaMBfCXQY3c1rf3FNXiYrPtv/ZKjxK6Xn7cE4Pa4jFv/opCBma+doKO43U8aLby5U1hEnL9HtrYgRiM6SGzuG+8MskRbcKSGeWTt8P2R/FRUOZG3pTRn8pwhew4+4DixnwapO1v91Vy4ZJIQA2siCWWJoK0p4ZeYou754wk+1wLJz6IA==
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by IA1PR03MB8192.namprd03.prod.outlook.com (2603:10b6:208:59c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 00:19:53 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9298.012; Wed, 12 Nov 2025
 00:19:53 +0000
From: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
To: Conor Dooley <conor@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>
CC: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix
	<trix@redhat.com>, Dinh Nguyen <dinguyen@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "Rao, Mahesh" <mahesh.rao@altera.com>, "Ng, Adrian Ho
 Yin" <adrian.ho.yin.ng@altera.com>, "Rabara, Niravkumar Laxmidas"
	<nirav.rabara@altera.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: fpga: stratix10: add support for Agilex5
Thread-Topic: [PATCH 1/3] dt-bindings: fpga: stratix10: add support for
 Agilex5
Thread-Index: AQHcUt+bNhBuCHcZuEWfBcVmhZeRFbTtLngAgACV0ACAAGoagA==
Date: Wed, 12 Nov 2025 00:19:53 +0000
Message-ID: <91cbe780-5b54-4511-963c-30e7e8442fed@altera.com>
References: <cover.1762835252.git.khairul.anuar.romli@altera.com>
 <0e3986dd9a2c4e46466a7430b2573d170d2a718a.1762835252.git.khairul.anuar.romli@altera.com>
 <aRL7/Hjb1Z/OrC91@yilunxu-OptiPlex-7050>
 <20251111-skewer-sturdily-989457c9fa70@spud>
In-Reply-To: <20251111-skewer-sturdily-989457c9fa70@spud>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB4927:EE_|IA1PR03MB8192:EE_
x-ms-office365-filtering-correlation-id: 31a5bbed-5c3c-40ca-c583-08de218133a6
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?M0JLUEdIdE9HMUpGNS9DQUhwa1NHSjFTM2tuV01WZ3VjSU9wZThEVWxxUDJz?=
 =?utf-8?B?b2c1TTdUUkRHeHVZc2t3ckpIWm5XcjhMTDE3UTNvamY4RFp4MkRxMGtvV0NN?=
 =?utf-8?B?Z0MvVTBqZXh5cFF4bmpSbk83NENWYmF1OW5iYmlLSys3ZXhtRE9JMElhV2Ra?=
 =?utf-8?B?STNTWDdSb2FUeVJWQ3VMaVoyejhxVnNWVFFTTkVGMG91WnZpUHdWVGwraW53?=
 =?utf-8?B?WnVlWjJvb1ZpM2ZWN2taa2xydUs1K21WeGYyT2w3blQxRVBzSWxQZVZtb1pN?=
 =?utf-8?B?ZVVXQkxlNFlUbmpkUEhOSHBHSUdKMTQwKytZSnNVMEpVemtaL29WMzJXL1lO?=
 =?utf-8?B?NnkzRTBLbmJaNUlpaFEzNHJZWGQzUktZOFRyNUJ0Q0FtdW1Zd0VEN1l0NENr?=
 =?utf-8?B?QmZZSFhzaTdBZGZUYUIxQThSOG5odHp5R210TFBhcHJtc0d0RTd5TkR1RlJJ?=
 =?utf-8?B?cXRvRitDb2NFTHYya0taOFdQN01iMzNtL1JWMit0VE0yelVScFowek5NYVYw?=
 =?utf-8?B?L1NVZmtRb0g4czVDWmJBQWk4UFNzWkY4UndQRHVnQU1LWllpMUtyMG42L08w?=
 =?utf-8?B?aXo1SG1zWnFNbnBmbFZPZHN2OWNDTEZpUnU1KzJlMEIzZ21kVVgyU2lKR1Aw?=
 =?utf-8?B?VEVKcWFYNmxuVjVpYTZ1UFE4ZTBOaFE1d2JyQWMvaHY4eE0zVDkrc2FGZ05B?=
 =?utf-8?B?dlFjWjJ3NUJqd2ZCTWwvTTRzell4bmF1dlIrbFhPZmtnVFFKSnR0RWpjRzBj?=
 =?utf-8?B?Z3NObnFOd1RSdzdmcW1vM0dyblZkcWliTWw2SWY4cnlsa3A3Mmd2T1lmblRn?=
 =?utf-8?B?anVQRHdsZG9xNXNoUytsbzNCT2RjODc3b2Z6NmduVEhzWFNwRnlsUVRXd1pX?=
 =?utf-8?B?TFpDd1hlZ2NmK25Td3h2RXJ3ckh0SnBVd1haZ1dVZTBKb3JGNHpCK0dwSXFH?=
 =?utf-8?B?ellBbmd5djlXeFlGb1l0cTRHdnIveEh0VnBtS0NSVFVYVDg1L0h0TG1lN0p3?=
 =?utf-8?B?VlpGbksvUHNSZUliRmhDdUNsbU8zN0NWNUlmTmxtVXo3bFk2TGJJcXRWamV4?=
 =?utf-8?B?dlhuSjFtTWtqWkhmalNMNjFSM015SE9YYktEZ3M0WXY0YmhwUEgzRXVRMkFx?=
 =?utf-8?B?QTRVRjNQZ25lYW1yWS9aK2xIRTlvQTR4TVQ2bDlMNEJCL05aZVdNa1JsbGlF?=
 =?utf-8?B?VWxKUHZwOFpCbWNJUVdzR1loVUlnRzNNaDlJVGFjU3NZNkUwTXU2U2ZiNDFQ?=
 =?utf-8?B?NjJvb2JGZnNuN3YrbjZKV1BQL1ROWlAwNEVWa2wwSWpyMEczUFdPZUhWS2hD?=
 =?utf-8?B?bjZNYTFkTEZGYzUzNVF3dWdORTI1TGFKdnZDTDJvbElOQTBCSzN5NnRiSjg2?=
 =?utf-8?B?dTA4TisxcXhldUswZ2M1akhIUGhLSjdZNGE0cVk3T1BjRGFrRjRQQzFOdlph?=
 =?utf-8?B?NXp6c3hVM1V3N1VITFd0MTZhWEM2VlhwM2o1MXdZVVhUdHNEa1lPclludlQx?=
 =?utf-8?B?d1Q0eElXejdmRklVM1dPaCtwQlBVS01ETUpRclNRcU4yZFdSOGIxc2IwTU41?=
 =?utf-8?B?R1BIRlg5eWVnRTFIcU1LeTQyaFc5YjREOTM0QlZ3Z0tYZS92dW40dnNRcS9G?=
 =?utf-8?B?MEtMS2V6NWdKS2MySit5c3VFTHZFQllRYUJ6ZlJGaXVlWkt4NzhZVzJxRTBa?=
 =?utf-8?B?aDl1UFhOeUdlVlRYVEFWUVptdEsrWmJ4Njd4NTlTSXU2VzJxRU54RWo2eTFY?=
 =?utf-8?B?MEwvYWxlcUxaL0U2RW9IZWVGZHRya3lYbnBCaEpFQzhpcThZOVJjMkhFaWhP?=
 =?utf-8?B?dU12TWtBSmpJTUVVckJCc1c4QXdDWTlENllYeU1QempLTWd4ZmlVQ1RXeUhx?=
 =?utf-8?B?K2h3a1RwMnMwTXEvWjhRaWhIYlg4TUJOUUpIOHZYd2hJd2RlZGlTYkhsNVpV?=
 =?utf-8?B?L096SUNRY0lQeFNONi9BUVVxZ2o3NjhkbXlhcWxXcWFFQXNCK0dnVkFCbDVX?=
 =?utf-8?B?a3NFSWlMOHFUV3Z1NVd5VFk5c1ovQ2wyWGVlamdKYlgyL2picXVyelVPTkpk?=
 =?utf-8?Q?5uIYqJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NTVsdU8xMWlJeXdZdW5EMXJoMm5kbVZ2Mkt1dFJkaEJyR212VXlKdTBBL251?=
 =?utf-8?B?R0FKeHZHZzFGZ21pVUZVWXV5VFRTaVZNdFhiZkN0QmY3Wkw0VWo1UVA2RFlt?=
 =?utf-8?B?TzRWL2pYQkx6bmZkd3Z6V1pDSkpDT3lZZ1Q4TkFjMkg2TG11T0xJZ0hYbXIr?=
 =?utf-8?B?TSswN3l5ejVRYmUrN3pxOTNNdWlTOC8rZHhjY0d4aFUzZXhaUy9lejdiMVh6?=
 =?utf-8?B?ZlhwYXdkNzUyNmJhRExrTGpJNGlQTFNDdUlRSWRjZUI3U3hqUGl2MFdUbHhP?=
 =?utf-8?B?V3B2K0JNTVRueGlneS9DdWQwVHFSOXV1eW91cmhFTkxqKzNEZFd4QTI3WTU4?=
 =?utf-8?B?aC95SWRpL2VsYlRHR2tSb0JrSnJINGY5V2FSZkFSRXhoUTBad3k4WTQ0M0lU?=
 =?utf-8?B?K2FnTm93eFQ4UE5RWDBOUlVjVHM3WEgzRWJnVVNxNlp6djVibW9pZEJEWDdF?=
 =?utf-8?B?VFg4WVhPQTgxVXM2bWs2Q0U0U3pvRmhyV01PcjQ3TWgyT2wyN2VncmVrb2hQ?=
 =?utf-8?B?b0dKcm12amp5K285WmlDYkZRRXpSUE1zdGpCeGVEZThUazFiMmNMWlNpaC9O?=
 =?utf-8?B?ZkhYQTJXT2J2dWJQd0tOaE5ZM0dUdU1FcE9nWUxnK1VzV2JnZUJpMlFZdkdu?=
 =?utf-8?B?S1ZWM1Rtd0RqLzBFd1diZEFUaGN1Z2Y4QlFQc2tPNGo5M2t5SE1tbFlnTDdN?=
 =?utf-8?B?TW1nNXliemNtVlJkdzFOWkd1UTE2L0J1eWZmWWlxTGo3S1RFcmZ4TFZQY1po?=
 =?utf-8?B?S1hNV3JxVENOUG5NV0g1cHRtWXFqa01rNXovNGd5UFU3ZkNxd1N4R0pSVC9u?=
 =?utf-8?B?bWVoaTZxQXJSK2xTREdneUVVSXNPWmgzNHdUNERlbUJkNG5xSzByS2gyb2Jx?=
 =?utf-8?B?WERTbDllamtYNVZGNjVBVGdsSXpCT0E1S1ovcHVhRVZzVlFFM09iQW1QYmlC?=
 =?utf-8?B?RlZrZmpWTy93QmgvRjJZODY4V2g1eEJ3WEhueUVYM25pZExOSUZpNVBmV2hX?=
 =?utf-8?B?Myt0TStUMFF4cmFadVB0MHZxOU95bGRqVWoxbU51UXZhaGNyREd3blBBSUdF?=
 =?utf-8?B?ZkNxVEpzdkRuWDdEdGVnQTBSRjZmZUZiU0ZNM0IrM2dScVpmT202bmNaQzN0?=
 =?utf-8?B?QnpFSFc1bko3RGNkTklsbllKR1BpY0NhRjlnT0lnQWIzd1VvWHM4TjZsVXhh?=
 =?utf-8?B?L3MrLzAwbTRjeWhIOHVoRmdzTmtDeHR5V1lMZndMZ1RoYnMzdmlLK0Q4QnZk?=
 =?utf-8?B?TUhGc2h5dndsczJraGpDTDJVOGgxak1hRkQ4NGM5dEhmQWp4TWhFWkNOQ3la?=
 =?utf-8?B?V2lZYmN0eE14S1luY2w0MFVHdm1VbE8xSDlzM2RBT1hKbVRBb2xWZnJZcjlo?=
 =?utf-8?B?cGtXY2FGbXdUN0hiVDdJbUg5RXM3WTNidWJ2ODRKSDJ0aEJTN2dQWjRzZWZF?=
 =?utf-8?B?UDBnWkVpUWtZeXl0Q1FTaldjTC94Q0dUS3dVRDZkQkFwMEpYcmx2eHYrdEZS?=
 =?utf-8?B?SU03YWdpS3hNMGllYTdUV3RZRFAydTFtYUtDQ2d5YlMwa3FiU1NSQnNkTWY5?=
 =?utf-8?B?RVBCL0p2bzJiaTF2dTA2SnhHTmRUTlFUQ3IvQUQrTmdqVDY0L3NaYTZ2ZEZj?=
 =?utf-8?B?M2lROFM4eGt0TWo5ak84a0VyMWpRSTZsOXROODRpZjRjZnhzWUt6STI3a0RY?=
 =?utf-8?B?ckdKQklDVjRrV1ZTbjdaOTBqWHZXQko4OEFjaWx0ajRBbDdlUEpFaGYwWGdy?=
 =?utf-8?B?bmI0RFY0KzVjWjRCREoxb1piWmVGNUxzMjB1bUdxLzdDaDZFUWVEMThRello?=
 =?utf-8?B?YlZMTGI5amxTbTk2ZVhMSFdGVHo2ZUxrL0N4TExFb3JYZFBuQzBITmNzYThM?=
 =?utf-8?B?aUo3bHFpZ05yMkJuUUsxTEIzek9rS25JSjdOL3I3ZXA3TzBkSlF3R3ZrbFUv?=
 =?utf-8?B?NU43RDIrQno5MXU4elZIeFlzOHpWNEcxNTZsSTRjTmJESkVFOGpkUXp5Mkp2?=
 =?utf-8?B?bjQ0QWlhVThVcDhISkJwN1JoUWFRT1BQUitvYmVMZjZxQWUrakhTYkRRc1c0?=
 =?utf-8?B?MHZPcE5uMGN1VTZlRUFVdXJ6TWkvamplOG5RRFFGb3BnTUFMMDdsRVVTT1Nw?=
 =?utf-8?B?N1p0Z05wQVdBSmkxa1QvM20weWhUUHpJY296VjhKcU5qL3BDL09YcDRyS0lP?=
 =?utf-8?Q?Zp26MxC48hdZTXc22kM474s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E40FA6A4A264524B893A48BA6D2C73D0@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a5bbed-5c3c-40ca-c583-08de218133a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 00:19:53.3824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cvdgh41ge4h+DEdfOrmACzquQkqCe3CR2JMfFtR+kHY6FQHjxedPpUQFrixCRgoIElkEObuG3fc8H6vTZVpUkBkJEXKsFiVdByc1FGWobaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR03MB8192

T24gMTIvMTEvMjAyNSAyOjAwIGFtLCBDb25vciBEb29sZXkgd3JvdGU6DQo+IE9uIFR1ZSwgTm92
IDExLCAyMDI1IGF0IDA1OjAzOjU2UE0gKzA4MDAsIFh1IFlpbHVuIHdyb3RlOg0KPj4gT24gVHVl
LCBOb3YgMTEsIDIwMjUgYXQgMDM6NDg6MzFQTSArMDgwMCwgS2hhaXJ1bCBBbnVhciBSb21saSB3
cm90ZToNCj4+PiBUaGUgQWdpbGV4IDUgU29DIEZQR0EgbWFuYWdlciBpbnRyb2R1Y2VzIHVwZGF0
ZWQgaGFyZHdhcmUgZmVhdHVyZXMgYW5kDQo+Pj4gcmVnaXN0ZXIgbWFwcyB0aGF0IHJlcXVpcmUg
ZXhwbGljaXQgYmluZGluZyBzdXBwb3J0IHRvIGVuYWJsZSBjb3JyZWN0DQo+Pj4gaW5pdGlhbGl6
YXRpb24gYW5kIGNvbnRyb2wgdGhyb3VnaCB0aGUgRlBHQSBtYW5hZ2VyIHN1YnN5c3RlbS4NCj4+
Pg0KPj4+IEl0IGFsbG93cyBGUEdBIG1hbmFnZXIgZHJpdmVycyBkZXRlY3QgYW5kIGNvbmZpZ3Vy
ZSBBZ2lsZXggNSBGUEdBIG1hbmFnZXJzDQo+Pj4gcHJvcGVybHkuIFRoaXMgY2hhbmdlcyBhbHNv
IGtlZXAgZGV2aWNlIHRyZWUgYmluZGluZ3MgdXAgdG8gZGF0ZSB3aXRoDQo+Pj4gaGFyZHdhcmUg
cGxhdGZvcm1zIGNoYW5nZXMuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBLaGFpcnVsIEFudWFy
IFJvbWxpIDxraGFpcnVsLmFudWFyLnJvbWxpQGFsdGVyYS5jb20+DQo+Pj4gLS0tDQo+Pj4gICAu
Li4vZGV2aWNldHJlZS9iaW5kaW5ncy9mcGdhL2ludGVsLHN0cmF0aXgxMC1zb2MtZnBnYS1tZ3Iu
eWFtbCAgIHwgMSArDQo+Pj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4+Pg0K
Pj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZnBnYS9p
bnRlbCxzdHJhdGl4MTAtc29jLWZwZ2EtbWdyLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZnBnYS9pbnRlbCxzdHJhdGl4MTAtc29jLWZwZ2EtbWdyLnlhbWwNCj4+PiBp
bmRleCA2ZTUzNmQ2YjI4YTkuLmI1MzE1MjJjY2EwNyAxMDA2NDQNCj4+PiAtLS0gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZnBnYS9pbnRlbCxzdHJhdGl4MTAtc29jLWZwZ2Et
bWdyLnlhbWwNCj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZnBn
YS9pbnRlbCxzdHJhdGl4MTAtc29jLWZwZ2EtbWdyLnlhbWwNCj4+PiBAQCAtMjMsNiArMjMsNyBA
QCBwcm9wZXJ0aWVzOg0KPj4+ICAgICAgIGVudW06DQo+Pj4gICAgICAgICAtIGludGVsLHN0cmF0
aXgxMC1zb2MtZnBnYS1tZ3INCj4+PiAgICAgICAgIC0gaW50ZWwsYWdpbGV4LXNvYy1mcGdhLW1n
cg0KPj4+ICsgICAgICAtIGludGVsLGFnaWxleDUtc29jLWZwZ2EtbWdyDQo+Pg0KPj4gSSdtIG5v
dCBxdWl0ZSBmYW1pbGFyIGFib3V0IGR0IHJ1bGVzLCBidXQgc2luY2UgdGhlc2UgYXJlIGFsbCBz
b2Z0d2FyZQ0KPj4gZGVmaW5lZCBzdHJpbmdzLCBkbyB3ZSByZWFsbHkgaGF2ZSB0byB3cml0ZSBk
b3duIGV2ZXJ5IHZlcnNpb24gZXZlbiBpZg0KPj4gdGhleSBiZWhhdmUgZXhhY3RseSB0aGUgc2Ft
ZT8gU2VlbXMgYSB3YXN0ZSBvZiB0aW1lLg0KPiANCj4gU29ydCBvZi4gWW91ICJoYXZlIiB0byBh
ZGQgYSBuZXcgc3RyaW5nIHRvIHRoZSBiaW5kaW5nLCBiZWNhdXNlIHRoZXJlDQo+IG1heSBlbmQg
dXAgYmVpbmcgYnVncyB0aGF0IG9ubHkgbWFuaWZlc3QgaW4gb25lIFNvQyBldGMsIGFuZCBoYXZp
bmcgdGhlDQo+IHN0cmluZyBwcmUtZW1wdGl2ZWx5IGlzIGhlbHBmdWwuIEknbSBub3QgZmFtaWxp
YXIgd2l0aCB0aGVzZSBwYXJ0aWN1bGFyDQo+IGZwZ2EgbWFuYWdlcnMsIGJ1dCBpZiBpdCBoYXMg
c29tZSB3YXkgb2YgaWRlbnRpZnlpbmcgaXQncyBvd24gdmVyc2lvbiwNCj4gdGhlbiBkb2luZyB0
aGF0IGR5bmFtaWNhbGx5IGluc3RlYWQgb2YgaGF2aW5nIHNwZWNpZmljIGNvbXBhdGlibGVzIGlz
DQo+IG9mdGVuIHBlcm1pdHRlZC4NCj4gDQo+IFdoYXQgaXMgYSB3YXN0ZSBvZiB0aW1lIGlzIGFk
ZGluZyBpdCB0byB0aGUgZHJpdmVyLiBXaGVuIHRoZSBkcml2ZXIgZGlmZg0KPiBsb29rcyBsaWtl
Og0KPiB8LS0tIGEvZHJpdmVycy9mcGdhL3N0cmF0aXgxMC1zb2MuYw0KPiB8KysrIGIvZHJpdmVy
cy9mcGdhL3N0cmF0aXgxMC1zb2MuYw0KPiB8QEAgLTQ0OCw2ICs0NDgsNyBAQCBzdGF0aWMgdm9p
ZCBzMTBfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+IHwgc3RhdGljIGNv
bnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgczEwX29mX21hdGNoW10gPSB7DQo+IHwgICAgICAgIHsu
Y29tcGF0aWJsZSA9ICJpbnRlbCxzdHJhdGl4MTAtc29jLWZwZ2EtbWdyIn0sDQo+IHwgICAgICAg
IHsuY29tcGF0aWJsZSA9ICJpbnRlbCxhZ2lsZXgtc29jLWZwZ2EtbWdyIn0sDQo+IHwrICAgICAg
IHsuY29tcGF0aWJsZSA9ICJpbnRlbCxhZ2lsZXg1LXNvYy1mcGdhLW1nciJ9LA0KPiB8ICAgICAg
ICB7fSwNCj4gfCB9Ow0KPiANCj4gVGhhdCdzIGEgc29saWQgaW5kaWNhdG9yIHRoYXQgdGhlcmUg
c2hvdWxkIGJlIGEgZmFsbGJhY2sgY29tcGF0aWJsZSB1c2VkDQo+IGhlcmUsIGFzIHRoZSBkZXZp
Y2VzIGJlaGF2ZSBpZGVudGljYWxseS4gQSBkZXZpY2V0cmVlIG5vZGUgd291bGQgdGhlbg0KPiBj
b250YWluDQo+IGNvbXBhdGlibGUgPSAiaW50ZWwsYWdpbGV4NS1zb2MtZnBnYS1tZ3IiLCAiaW50
ZWwsYWdpbGV4LXNvYy1mcGdhLW1nciI7DQo+IGluc3RlYWQgb2YNCj4gY29tcGF0aWJsZSA9ICJp
bnRlbCxhZ2lsZXg1LXNvYy1mcGdhLW1nciI7DQo+IGFuZCB0aGUgZHJpdmVyIHdvdWxkIG1hdGNo
IG9uIHRoZSBzZWNvbmQgY29tcGF0aWJsZSBpbiB0aGUgbGlzdC4NCj4gDQo+IHB3LWJvdDogY2hh
bmdlcy1yZXF1ZXN0ZWQNCj4gDQo+IENoZWVycywNCj4gQ29ub3IuDQoNClRoYW5rcyBmb3IgZ2l2
aW5nIHRoZSBwcm9wZXIgd2F5IHRvIGhhbmRsZSB0aGUgbmV3IHN0cmluZyBhZGRlZCBpbiB0aGUg
DQpEVCBhbmQgYmluZGluZ3MuDQoNCkkgd2lsbCBkcm9wIHRoZSBjaGFuZ2UgaW4gdGhlIGRyaXZl
ciBhcyBzdWdnZXN0ZWQgYW5kIGFkZCB0aGV3IGZhbGxiYWNrIA0Kc3RyaW5nIGluIHRoZSBkZXZp
Y2UgdHJlZSBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpUaGFua3MuDQoNClJlZ2FyZHMsDQpLaGFp
cnVsDQo=

