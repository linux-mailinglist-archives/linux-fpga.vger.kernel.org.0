Return-Path: <linux-fpga+bounces-1456-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFC3C56870
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Nov 2025 10:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6635734104E
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Nov 2025 09:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F94029E0E5;
	Thu, 13 Nov 2025 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="ZJp8drlr"
X-Original-To: linux-fpga@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013052.outbound.protection.outlook.com [40.93.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EE1286A4;
	Thu, 13 Nov 2025 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024970; cv=fail; b=OLJtM6teIMmCyd8IRnFZJ1iSPbKI0iWELabn0ogCnKqoQFYHWjMGG2oR310slHO5eW/W+4+BFtBBfPmYHQLdBIlK1ysk+xqeCDk0hJeMwIXnbKFviKxdqEl9We5YFUb81yzItZbb5fUj3OMFgJn5n7sm8qXWY6/FRpNoRxqlDMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024970; c=relaxed/simple;
	bh=xJyc/EYA3r8tp53Hz1hvTqKaY8QEKCL7xZW0G2B1vtg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uYRZNdQ4tItgSoIugTdd7kxL59Bqk0qJVL6jFFvsj8UBoX9Jid3iALVcsnP1R3+jCgN99AWJnyRAiTZK6UGU2u1f1ffklxVk1I0Ob8zXoTV4tBkJjzhO4JDlces046Qyp5eDlX5JJtODn5DvHpyFKzedZ1vY7dQYDJtBG/kaDwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ZJp8drlr; arc=fail smtp.client-ip=40.93.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=devK3B1bpZJ/76RIVB/S9/32dFV6KmPye7hKMKZGCOo/u5Qd0C/OrjzfxME97UvRJeNzGieJjTqa1QUhkISBp1GoE9b8CwE2Ajtl3jtyc8d7Z7ihBKp1uuUERMwiWgI6gMxBW538lhcn9PYlEVjObTwIvzsUInCg1/uNGkiAxW2A3F9ADsgyIZa/ocAZx1uDtNGNPT+avG7maGXnfQZ10nAPwLpHm0oqwVu+nb0Rf+vgH3RFq7569XjTjC4mJEJYDRzp+sIzLp+A+j92KZYaXQ9Azo0L8Kc8VWbjr0jOrVfn+Ch0XXfCJ769xFV2FYdlmL0GLbzxQeqo2rAlXwpQMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJyc/EYA3r8tp53Hz1hvTqKaY8QEKCL7xZW0G2B1vtg=;
 b=DqJSCKgwKRHHqTZOcDqz34z3lL8EoHvL5niVyurg3fNSnJxhSiGJ4Yel3LiykHEn5qXZZcf1/KcW5sGnPapYrXILSgPf0Xf4aH2l/92IM25I0T4vFQGVGB5EjWmRhW1Ssrw1PgBxVYwHYlTkkBitHYUu14TDvg4ZdFZo6E8dBwN9avbJ96RnCThsurayacJ0JaGMkFjSNIBBz3pP2z7wmnZeLaGhOq7dDlyZir1CwezrsFtwFzqRnR6RmaN7NCfqvXVc8/MQ7sdJ0vwOx/7wQZAomzcUf06BxGv38EhGUgP+ymLZQBebfK9ChspiiD1pW5dR0LinDETS7CGPTB9NlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJyc/EYA3r8tp53Hz1hvTqKaY8QEKCL7xZW0G2B1vtg=;
 b=ZJp8drlreH+VbYDE0V+Tzw15GfXMdToiUNVKRwTSm+zZjX6HGaT+qP0+kyzAuyeTF5S22fMUXRvg2uSYgNaAK2ujPtqP02RtDGxurR5YAABCmO5b5gl799IjHCNtnT2uiFuQZna8lg15SDM5EWDNEdwGyKJkCNNIRJAx0aqmjmR24t0kWHDT6chSUwrVWgfukOL+4EXxZSrrIdmULwHMIo3jE69doUKZ7iBkOqMoR5Uy3RwKuhnFLPSuWgx9X3qiuft/MLE4cbN4En9DzsVOBwr4XW4hQsE99dLWWJmX/tyTbTgLRPHB1XTJqewzB2hUUANW7KsOBp5D9baNMMeXQQ==
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by BY1PR03MB7238.namprd03.prod.outlook.com (2603:10b6:a03:52d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 09:09:25 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 09:09:25 +0000
From: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>
CC: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix
	<trix@redhat.com>, Dinh Nguyen <dinguyen@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "Rao, Mahesh" <mahesh.rao@altera.com>, "Ng, Adrian Ho
 Yin" <adrian.ho.yin.ng@altera.com>, "Rabara, Niravkumar Laxmidas"
	<nirav.rabara@altera.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] arm64: dts: agilex5: add fpga-region and fpga-mgr
 nodes
Thread-Topic: [PATCH v2 2/2] arm64: dts: agilex5: add fpga-region and fpga-mgr
 nodes
Thread-Index: AQHcVFgvUWrqT88/SUawtfOUkwfJ07TwG3MAgAAVlACAACCxAA==
Date: Thu, 13 Nov 2025 09:09:25 +0000
Message-ID: <59344226-be4f-4c90-b7dc-8c2a5a471d80@altera.com>
References: <cover.1763008269.git.khairul.anuar.romli@altera.com>
 <9a4ce6b2470328b9326402a2f00ff285be1793c3.1763008269.git.khairul.anuar.romli@altera.com>
 <aRVyvjCny/I/rElC@yilunxu-OptiPlex-7050>
 <c7470b9e-5c8f-4498-a752-9c986de8aca2@kernel.org>
In-Reply-To: <c7470b9e-5c8f-4498-a752-9c986de8aca2@kernel.org>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB4927:EE_|BY1PR03MB7238:EE_
x-ms-office365-filtering-correlation-id: 649bd27b-7ca2-4ca5-318f-08de22945786
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aUVGaTRCcTBjNUJSdzJqZFp5d01DbkNYZ0RIQmF1L0x4QXFhOVJ4QVRpaVo4?=
 =?utf-8?B?ejErRE1hMC9oWHhMaEVLemtKaHVmMmd5SVFGNUloaVNGQ3JkRlV0WjV3all2?=
 =?utf-8?B?Nyt2ek1tT1VEK01HaGpWSnlGdzJxZ2IyYVJrMkpGblFYUnQxYjlhM2lRaFJq?=
 =?utf-8?B?eEFzdlZGcGx1K2xRclZ4ejhQY082T0FicGswMWVoaHJhUnQyNXhmMWc4THda?=
 =?utf-8?B?NUwrbHA4VExVTDAweitkNGhHSFk2d1h2LytqUWVlWERTTUl5UE9CQXpVNXVP?=
 =?utf-8?B?MTgxb1gvWVZnalBXaVRjbGdiUmUrdEVWanlxTThvZ3M4QTd6ZjhrdXBrYUQy?=
 =?utf-8?B?UlFBZjV3NzV6aXJ3Z2phVTVqVVFkcW55WE5Ccnpmc2U1VllBRm80UUQwc1dp?=
 =?utf-8?B?c3BoMGZFNXlnL3VRSWdxdVpEVGsxTlJBdjVNQlFBelZNRVEzRjluUmdrN1VG?=
 =?utf-8?B?VHNwa0cwYjZFM1hmNDlxbi9tQ01zaG8yUlBScXUxWUxYRUdvcDZhc2ZyTTQr?=
 =?utf-8?B?YWMyWktkNkVxYzBMVkVsQVF6Uk04UnFNWldTZzhYT1VROCtyVTZBWkd3S3BL?=
 =?utf-8?B?OGRFcUl3MG1mT29PMFpIazVVVllScXl2TG9lUUxsMFpER2I2dW8xbWcxTkFB?=
 =?utf-8?B?UUtwUnRZbDBXbXQvN0dyNDZydTdwYVZ3Q1pxR3dNMlVHYWZtZllVSUpVa2NV?=
 =?utf-8?B?N3VYOTJrMlBsWHlPOUFtbWZuOGJLUHZIUGRKend3NjJrQVcrZWkyMkNoV05W?=
 =?utf-8?B?WUdnY0kxMmxkMnNRMktCdngyY0dZS05mN0xFOWRVaDl6K0psckZRVlFnaW0w?=
 =?utf-8?B?SEcxaDlDQXFhcE5UUUxVaWFaSTMwQmZIejl0RWkxQVNOOVVQbzdrT0pIZW10?=
 =?utf-8?B?Ym9VVW5wZ25MK0ZtTit0cmxKTmg5YjA1REtQMzk4ajVMRGdrNUVRajEwSm9K?=
 =?utf-8?B?Uzh3c3dTazM5VkhQSUpQVjdodWYrMytNdWRscElwdEhpc1pXckZaUGFxTzNa?=
 =?utf-8?B?M210SWlva3Q4WGNQbzhsTmo1SWs4MitnNnpRZUtNSGRjdHBDTS9xRVJoMHE4?=
 =?utf-8?B?RlFhcWo5cFJPWGZYRi9URFVHb1gzN1lUVktCMSsyV3pDM3h5c3YvY2xCWlYz?=
 =?utf-8?B?NmwvY3V1QkFBN29CSTdqVHFScHIyaVdld21xdHlXRk5SMXp1Y3pXUzVETDZG?=
 =?utf-8?B?empDRGYxMGZ3cjMwcTFrbU03akR5V01pdy9WcTBaQ1pBaHBRbEg0U1BaenZ5?=
 =?utf-8?B?OERaUWlyZEV1Rk1iMlFicjBaUEkzR2g3VGIyRmt3SzBNSCs5OUJacmpLVGlR?=
 =?utf-8?B?eERiUSt6Uks1djFFLzEyWXlrNmJkc253TWV3RitRVjdHYk1GVWg3ckJSeXRW?=
 =?utf-8?B?L1JyZlVLYVlkaHNpQXZ1d2FzOUxYKzA4STU2ajdzV3NSeURuN1JFNjgrQ0hz?=
 =?utf-8?B?T25sVU1KbmRZVDVtbkZNYUVOZXp3SEFsZXhXM252VWNLSVV5cEpuV0h2OWhG?=
 =?utf-8?B?NUo1amlsZklLeU5tQjNHM21velRKTUN6UHZaN2pQM2lWNFBSVW1Za2xUUnJ0?=
 =?utf-8?B?NVVxdXFCVk9ISmxtM1dyU3lJVnMzVENnVmRBWDJPK1IyL2lGUkVvZXFXMmRj?=
 =?utf-8?B?S2c1WGpOOUEwTFh4cGcxc0orMm52KytTZTlIeXF3VzRmSnhSZkdwOUFRdkgz?=
 =?utf-8?B?dTJyUDA2bE53Y2ZISGpwd3hzK2tCZUk0SHdoRjBaWjA5cUN0c0UrVlNHSUtC?=
 =?utf-8?B?TUxjL0x3T29WZkhUVklWaGNRanhsaHV0dEZUYmpyWS9lK2RWRlNra2svbE52?=
 =?utf-8?B?N1ZjREk5MGRyQjQzWnNBSzZPMk8vNkJxb1lhV1FFWE9FOU1FMlhvdFZOd2I5?=
 =?utf-8?B?bTliTWhQenhjNW5BVHc4WnRJT1VteE96OHl4ZStHWUE1eWZZTXUzRStxTUpP?=
 =?utf-8?B?T2N0S1FTUEh2bzJmOE5qNHBmb25tSXBlWmdrRXdNSHFiSkNVZURBWlU5MktT?=
 =?utf-8?B?eEh5N3VKd3d1VU5QWU1BZTdnMGFkYUxuUVNSWDhkM3N2dEhrOXI4STZRZkh5?=
 =?utf-8?Q?8KpfpR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y2Y3bkZJN3NZM2M1MllwaFpHZU5CaGgrQWlKRnF4c25ka053V0FwMFdUR1BU?=
 =?utf-8?B?U2ZWVFZnRlMyaGlYN0lwYVVBZHVFejZEbFl3eDRneTM4ajhGNTVpSS9NNEZk?=
 =?utf-8?B?a1lwckkwNlVld04wcHBrYWdSbmRFZzVpY1p1UksrdWJld1JUWjNjV0dnNzJv?=
 =?utf-8?B?clgzSXhObHZIY0JHRjJ0bHJjMTVjS1ZkU1JOdm1KN3FpaG5ycDh6NDU5dGtx?=
 =?utf-8?B?UmxabFkyMXF0QldyYjFZS2JvT05YS0l0RjNlc29HcStta1luQkhwZDEwM3Fs?=
 =?utf-8?B?YTRUcnBKSDZYY1dwNUVydlEzdm43R3B1MEhCaVRNTU53NG05NXUzZ0gxbUQw?=
 =?utf-8?B?eS80bk5NSzh4S2s4NzhPZHVlWjYvRXh3eUtJMlVDTGNXTElzd1BpM2tOZFJ2?=
 =?utf-8?B?TFJ3QTMvOHJsbkZLeFYyYWN2bGIrdEl1N3F4bDJFaDRramI2ZzV6MGUzNVp1?=
 =?utf-8?B?eC9QMHJSbzRhZlA5Qm0vc01kNDZaZmtGUnRhSzIyaHhuYXJDMllMdUdwaTJN?=
 =?utf-8?B?a1I3bGJYdzF4QmVkVnphWnNXVXlSdzNUYzQxKzRIcno1WEIyTFM2V0tmWkEv?=
 =?utf-8?B?NE12NEVEbGhScnVVQ01DSG1ubTBJYllUM1FLUlg3TTE0S2ZoelNzUXQ4MWgz?=
 =?utf-8?B?Y1FidkJ0UHRMZCtsYmZZSlJ6YTcxVmhINWJjNE5IaUJqOVF6K1RlbGdxSGpi?=
 =?utf-8?B?ODloMnFLWnZ5RHRNUDZNQnBjeVZ5MzdoU3RPSTBNR0VtTlVsY05BZGZaNWlF?=
 =?utf-8?B?UmJJa1Z0b1dYVDcvS0NWT1hZaGRjbE4vaWFlR0hEMGM1RS9OUzFjOVZOQTdL?=
 =?utf-8?B?U2RlaGlQekZLamV0dDZNdkZUOHgxSEFmRWE2ZXV6dHIxREpNMXRORzR0MTR3?=
 =?utf-8?B?KzJENWNET3JhenUrekdrTkduRVhkQWwvQjlLVW1WRVdid21RS2duU3pzblRy?=
 =?utf-8?B?UnIvK2NiclJONWE2ZmdSeENzSUhzZ3hhVTlNa3ZXSjRiYWRrcWw4S0J6RzhJ?=
 =?utf-8?B?Y1Jta2daSkl6L0VaTHFBZkY4M25FcjFWbVRuRUljajd2RmpBQVo2d0s4MWlY?=
 =?utf-8?B?QkI0aVhBa1dpQlhEY0tXR09zOGNwVFVlazhiU3ArWW1hNkl5QklCNTF2d2NU?=
 =?utf-8?B?UXdmRmdwVURWaWY4aWVIcmJTbWplWUZWb1ErY0tTTVA4V04ySFFBWTgvR2l1?=
 =?utf-8?B?bEMzUy9qdzFPUnVjNVcwUjdSVFFKLzBJbjVBRGJDcHh6aXhKdStKVndxdVYr?=
 =?utf-8?B?QXZYVGNkRTZZNWd3ZldPd21QalRhNTBoUjdzZEVCMG5sVEcvSFJSajJERTd3?=
 =?utf-8?B?ckJPLzN2YWlkR2p0OFRtK2l1ZC9mWGpMMFFORnVDS0I4WDFESDAwQUIyaURq?=
 =?utf-8?B?NHpiaWgrdmlodHRaR0RhRGhRVDZIQ09RK2o5WWRnY1RiQ1BIV3N4SWV2d3dj?=
 =?utf-8?B?ejVhaGlnWnhEazZiVlpMeE14Q1BaaFJncU8vRXNFVXFzQWlVUGY2UUs2K2hx?=
 =?utf-8?B?aUlKbVNQbVNrTXUwdkhqL2dQQUJLa3piUk9qZXhoSVE3cGxwT2RZSnJCa05u?=
 =?utf-8?B?bHM3Y29HK2VhT0gxNmJBNkFsTm4xWWdoLzFmcE1tOXBZRHBLVzhRY1diSGRJ?=
 =?utf-8?B?Y2NhdEFDWCtNMWduaExIaW83WHgrUDR1VHV0VUkwMGJzb0FwQ0FrbFU5WFA5?=
 =?utf-8?B?eGhsbWk5SkxDUVh0SGhaRTZrRFkxeGRUTlJaQXhVU1g4eWJQN25mbjIvVytT?=
 =?utf-8?B?Y0d4dWxmMnNmbkYzQlhJaldHclFveEVxTk1lZzhYN05iOWtsYnhwZldBZWZD?=
 =?utf-8?B?NC81a2c5Unl2TmZ1OUd4SExIQXNPQW8rRUhBUlF2dVgyOHhnc3EvZndwdTk2?=
 =?utf-8?B?MDFOejZJcm5LSmtPWkN1QU1tOHZFWkZqQmFKcnN4NU53aHJjUjFtdEVURnlB?=
 =?utf-8?B?azFVK3Y0R01waTMxTkhKazFQU2JuYnZBWGRJUzJ3R3c0c3Vqd00wYUNHSHlp?=
 =?utf-8?B?VlFockU0cXBjRGhhZXZ5TmNreXprcTFlVVNkQ0VuU09xRUNXTUJURHovT2JI?=
 =?utf-8?B?T1lDL3VwY2szZEUzVHg2VXBQaVdoRnpZWjltNW40MnFHekNnOGhiaS8wOEhx?=
 =?utf-8?B?ZmlVYkVZQW5lblAxYmRHRVM2aTNDYVl5eDRqNTlGakp1VjB2U3BPOUJXM2F4?=
 =?utf-8?Q?RV6ujekCnupuby/WRy897tU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4048D1602C8314D901E9B44E574B41F@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 649bd27b-7ca2-4ca5-318f-08de22945786
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 09:09:25.1834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlQ/qqb8/0SHShOMuHbSLdme3uFsnHy5btrxvpz/gXGAlw2A4JHH8vDK8bkWXRftJoGzqliZlvtRajfDQNXwehusvJM8kQOgZXKvg+XyMgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7238

T24gMTMvMTEvMjAyNSAzOjEyIHBtLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBPbiAx
My8xMS8yMDI1IDA2OjU1LCBYdSBZaWx1biB3cm90ZToNCj4+IE9uIFRodSwgTm92IDEzLCAyMDI1
IGF0IDEyOjQzOjU2UE0gKzA4MDAsIEtoYWlydWwgQW51YXIgUm9tbGkgd3JvdGU6DQo+Pj4gVGhl
IEludGVsIEFnaWxleCA1IFNvQyBjb250YWlucyBhIHByb2dyYW1tYWJsZSBGUEdBIHJlZ2lvbiB0
aGF0IHJlcXVpcmVzDQo+Pj4gcHJvcGVyIGRldmljZSB0cmVlIGRlc2NyaXB0aW9uIHRvIGVuYWJs
ZSBGUEdBIG1hbmFnZXIgc3VwcG9ydCBpbiB0aGUgTGludXgNCj4+PiBrZXJuZWwuIFdpdGhvdXQg
dGhlICdmcGdhLXJlZ2lvbicgYW5kICdmcGdhLW1ncicgbm9kZXMsIHRoZSBrZXJuZWwgY2Fubm90
DQo+Pj4gZGV0ZWN0IG9yIG1hbmFnZSB0aGUgRlBHQSBoYXJkd2FyZSBjb3JyZWN0bHkuDQo+Pj4N
Cj4+PiBUaGlzIHBhdGNoIGFkZHMgYSAnZnBnYS1yZWdpb24nIG5vZGUgd2l0aCBjb21wYXRpYmxl
ID0gImZwZ2EtcmVnaW9uIiwgYWxvbmcNCj4+PiB3aXRoIGFwcHJvcHJpYXRlICNhZGRyZXNzLWNl
bGxzIGFuZCAjc2l6ZS1jZWxscyBwcm9wZXJ0aWVzLCB0byBkZXNjcmliZSB0aGUNCj4+PiBGUEdB
IHJlZ2lvbiBsYXlvdXQuDQo+Pj4NCj4+PiBBbHNvIGRlZmluZXMgc3BlY2lmaWMgY29tcGF0aWJs
ZSBzdHJpbmcgZm9yIEFnaWxleDUgYW5kIGFkZCBBZ2lsZXggc3RyaW5nDQo+Pj4gYXMgZmFsbGJh
Y2sgZm9yIHN0cmF0aXgxMC1zb2MgZHJpdmVyIGluaXRpYWxpemF0aW9uLg0KPj4+DQo+Pj4gU2ln
bmVkLW9mZi1ieTogS2hhaXJ1bCBBbnVhciBSb21saSA8a2hhaXJ1bC5hbnVhci5yb21saUBhbHRl
cmEuY29tPg0KPj4NCj4+IFJldmlld2VkLWJ5OiBYdSBZaWx1biA8eWlsdW4ueHVAaW50ZWwuY29t
Pg0KPiANCj4gSG93IHRoaXMgY2FuIGJlIHJldmlld2VkIGlmIGl0IGlzIGNvbXBsZXRlbHkgd3Jv
bmcgYW5kIG9idmlvdXNseSBub3QNCj4gbWF0Y2hpbmcgdGhlIGJpbmRpbmdzIGZyb20gdGhpcyBw
YXRjaHNldD8NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCkNvdWxkIHlvdSBw
b2ludCBvdXQgd2hpY2ggcGFydCB0aGF0IEkgbmVlZCB0byBmaXg/DQoNClRoYW5rcy4NCg0KQmVz
dCBSZWdhcmRzLA0KS2hhaXJ1bA0K

