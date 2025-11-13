Return-Path: <linux-fpga+bounces-1455-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4ABC568B9
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Nov 2025 10:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71D0C4E3BD5
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Nov 2025 09:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE6627E1C5;
	Thu, 13 Nov 2025 09:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="TQS+ZFC6"
X-Original-To: linux-fpga@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013010.outbound.protection.outlook.com [40.93.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC27286A4;
	Thu, 13 Nov 2025 09:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024846; cv=fail; b=jBpRiaKPF4oo9u+V6T0uRLvE7jbkmRSY1CrDoJ+DJA+H+003QbB0JfEoUJBfgTqgSq7zl6QzHHm8tbczKKq3Yc7WEoHtsQvrS1qMnES2MRt4aeiu6Eu5Ssudupqq4bC/PZHkYjyGLcCTbwIvlXOMfMG1oQ6JDqFrAr9KETdUF/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024846; c=relaxed/simple;
	bh=vhb3oPUEPIe9QbvvDG7RBr9Kl9/ecUQxbgkLD/0LSOE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QBwKdpLxGc3kgVXs39Lzy0kKGl91T3ao4CL5+hdRp1BKKoPm7iQksMIyX8eP3rqwGMDkqRFkHOO0V6pcUoqFa7T8nNT1TvVuY1BoxlvIwHwDTU+nOp0/DtrSOgkCq7PJb7/AS3NqU64qT6bXPQ1gWGKsompyd38wORDNW89sc1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=TQS+ZFC6; arc=fail smtp.client-ip=40.93.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRhwfadc9jpH0Kt6A6ClcNxPsoxghYMRc/LEFqOszAZSFmjGHWRBMFKIhjjQSgrnxnZqkDIsrqOuHIfE+9O4sSb1/vKS6mO5azia4j2O1YopZU8UKn+Iv2MZTPF+pOq4YfJ/xfQKIZHn/Aa7CexPjIgn/CCRcUc4AWMbBEPJTH61Fo5BVRyxh3ZGP7q+m8/TlWUGOb8q5PrqJHpDHb/gYgzp1rgYfwbHfA2lXmlPpdvK5QVHiRIK4eVr5cdpPWH4HKTR9k7x7DdBXqAvWI17opnAhk8gcJiag55o+I8T5WnGgJAR6UJ48tzWL8sjdgxur6pzSTpZXTbJUBOeiUf2Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhb3oPUEPIe9QbvvDG7RBr9Kl9/ecUQxbgkLD/0LSOE=;
 b=J4SfOOPo79WcqoF5aSaauYBhNBhFc4+wz03m7YOEeNkXw+bjSnSPnu2+/FPzsC86G4FTJyJMhngXsenNOAglUWaVXBTWAg2UMpMYko7HFvsOG4pQyuMscHE7fhbo9LnnB6ELSSuU49ocFbhaUeqQNe3LUueBCBIxnujoTG0XGs7YxaIIwUmFqlK0SDWK43jEJXKqZxodxEKWZKGeYyXCBY4/7R2vIWWtnoBFGxOKteBISdyXOQsJ9IbDGRu9Y5bKZURmlY9gfL9wRaU34/KcdGcvAbpY8hWFwTWmYu70uejtV4SGem7rnHXfcdatKCnxwSmZJqjbALUlHyW+uzULdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhb3oPUEPIe9QbvvDG7RBr9Kl9/ecUQxbgkLD/0LSOE=;
 b=TQS+ZFC6mUkGMg0hQuoRyYELPPc8gtc8I9/O0L8WYivCA9o9LWu+lVN9O0rdGv2WlGZrnY5FBpqgRUvpuqAdGQLWjyxDEEgBRHvwXo/mY/liaLezBsJJG1ZkN8B/TXoYje74N5bBlpQEA4m60IDlTvsxX2TK+ufHRlwK8SdAv63VmpU7o+TOxGATWirnURv3KADDaYrXPHGmDYptp2mbw3OBsHO6Aw4ftP4pPJnbcvRWaJWb1/X81JUefeWyJ7s7CclOP3+1RJUVx/YQPYh0l/nZKUrZ6D+M4oehKmayPF0jU9y5/PMDLlCWLDw1ipEfVjy+gvTlGjsG4fiqgWL+QQ==
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by BY1PR03MB7238.namprd03.prod.outlook.com (2603:10b6:a03:52d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 09:07:22 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 09:07:19 +0000
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
Subject: Re: [PATCH v2 0/2] Enable FPGA Manager support for Agilex5
Thread-Topic: [PATCH v2 0/2] Enable FPGA Manager support for Agilex5
Thread-Index: AQHcVFgjC6R2hGI81EaKjKdwifePr7TwHVIAgAAT/oCAAB/SAA==
Date: Thu, 13 Nov 2025 09:07:19 +0000
Message-ID: <cdd2d579-65a3-4e1f-b8e8-45b30a6d9848@altera.com>
References: <cover.1763008269.git.khairul.anuar.romli@altera.com>
 <aRV0UCZD6fwnfWUE@yilunxu-OptiPlex-7050>
 <a0214340-d0dd-4689-9692-d934f3a80c40@kernel.org>
In-Reply-To: <a0214340-d0dd-4689-9692-d934f3a80c40@kernel.org>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB4927:EE_|BY1PR03MB7238:EE_
x-ms-office365-filtering-correlation-id: bf5b6539-3dd3-4e5b-80e4-08de22940c77
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?d2tkWnNkR0QxeHQrOEhIMXhwcEZtZHZJV2dzVm0wK1ZPdjE4SnFEcDVYbkFW?=
 =?utf-8?B?YVVmSnN0Ym1LTjRJaUUrTGxYeXRwa2ZBVDdCZlh6NnNJczNjd1cycjFxWE5G?=
 =?utf-8?B?dWFkOTVuelRlNHdveTdUZGwwR1Q3U0c2YlRvKzJ0bk1jVkpXTk90cWplempB?=
 =?utf-8?B?VWhDTllRR1NiekF4dG1RMjJ3cW5Zd2toK3l0OWZaSFlZZEJMSlRxR3FOb0xZ?=
 =?utf-8?B?Y3VrdklERXNiNWUwMHdXR1FRS0dLRkJ2UU10N1NsNG91dUQrdjdwL2sxenpO?=
 =?utf-8?B?WHZWdlRPYk1QeGNSSElIWkljTksxWkN0UDFKYlMwSnVSSkc0SVFxenlRanlX?=
 =?utf-8?B?MGwvMW5RYVBQSFZMZ2h6UFprMnZMMjR3blpJdTM2SmRFRDRHM0MxWDdjVTly?=
 =?utf-8?B?dGRDa2FVQ1ZKbUZWMlFNZ1NPajkxM2g0eTdjMTZMYld0ZW1JN0sxdW0zYWdo?=
 =?utf-8?B?M3NJTnora2lnOVJEejkyRFR3ZUFpUGUza3krUnl1MkZTWVh2Q2tYNW9pN0JP?=
 =?utf-8?B?RmFzUldqNEQ5K3NCZ1pnUENzbUxiWUkvMTZZcFBDN1FBU3krTWhWMEo4clkr?=
 =?utf-8?B?cUxydUJOeS9ZRWVPcGtCMkpld1FqQ2dLZVAzcUJEcDFGd1E3NTFmVDYxa2VG?=
 =?utf-8?B?U3laSW9TclpPZE4xbTFJQmRnSnhPZzh5OXRoc3hBMXBuQkl1UDRTek13SW1U?=
 =?utf-8?B?Y3BPVm9aNTc2dWhkMVVaZldFSk1UaUhPck9oMjN0Y2lFeHNDS2NIaG9vK1pL?=
 =?utf-8?B?SGdoek1tWkNaRGRJR1BOQWdIV0hlT0t1bmpxZDE4cHYwMFZvOWhNTHhSSXRz?=
 =?utf-8?B?TFdBRng3SDdlQXhVOW5QczdUZnJ4NDZpZk9nbjlmNEpmZndyaFNWZXIxelJi?=
 =?utf-8?B?VVNibDhJUmltcDVEVkdrMVFzdkFFNm9zaFZVRkxpU1NKbHBZVC92WFpXNmhs?=
 =?utf-8?B?WnR4WGVOb2g3dldiVldRd3BEcHhGRGZWUVZlbVJBNllxazBablVtMHJCSnhV?=
 =?utf-8?B?ZVdNSmVIeXc2MzdoSVowRUR5ZEl3bUJJdlpoY0ltQlUyWDlYQzBPMG95QzdE?=
 =?utf-8?B?aGprajZxemFvL1FQU3B0amhWNEFQME9MRFVYOGtxWlgvMXBKTk8yZE96VVAz?=
 =?utf-8?B?NDIrR2pOdlo5Y0Fpc01tNXBsTWZwTG92QnJNODZVbWZsMktSR05rZmlVclBU?=
 =?utf-8?B?RFFaMUxySFYvNU5KS2tnbGJ5LytBbDVwTVdCdVlvdGg4MUhobjZHdS9ZUXdU?=
 =?utf-8?B?TFp1Z0VQek16Z2pQRmFQUlliWDZucmdXOEhrazlGMFpVWTJCM2VtWkZydGJw?=
 =?utf-8?B?TXg4SUhNMWNOS0NvVHIydkV2QlBZYkpzUklZK25VRER4cVZKUGZCMWFuaWFH?=
 =?utf-8?B?SXRTTnpOY3licTg5bEZDbnpkU2dBeHJ6dURod1dqMFhFaEVIM1ZNWk45bXZR?=
 =?utf-8?B?czIyVlVsdnpjNnFMQVF2MktmbXhBdExmY05YVWZuUXRmWVgwTzZtRy8zc1l4?=
 =?utf-8?B?Z1JnYmw1UDM2N3UxYVplWGo4THp5OXlMdFkzd2lzL2R0NEpQRnFoVXhrTytK?=
 =?utf-8?B?VThJdHN4VXFoeTFJeUVJdk9HcFVDSXVMMVUzSXBCSTFVT1YwdnFLajlud082?=
 =?utf-8?B?S3Y5RGdsU1VON1J0S1JXamJ6ai9VQlNyemZsT1lnejNodHh5YmlKeitkQTVy?=
 =?utf-8?B?S2FVZzlvWlVSYzl0d1QwbUZ2eGhnZkF0ODVBS1BRYnNMRERTV3BOT1Z5THdO?=
 =?utf-8?B?QTRGY1RXYkVQYWN1WFRvRDRYVjhIQk9jcVRFYnYvWCtTN3NUYVVPQVhjcXl3?=
 =?utf-8?B?L0ZjY0h1a1RFcEEvOVJTYnM3cUdwOGJKMWpJYVF2aVVqaEc4aXRaWVpQdGR5?=
 =?utf-8?B?RlZLL2hLcGx6KzBkTEs3WFNMVUoyVllOc3dxUDVDb2tHWWQyZkdRRXA1d1RJ?=
 =?utf-8?B?d2RveUh0Q2ZmYU4zUnV0clB2VklmOTJaR3lnWjBZa0VOZzFYNlZnMGk2enNX?=
 =?utf-8?B?MDhhdjV0Z3pCM2FybHhJQXhsVGI3TzVweXlZQjJ6R1VXSVFpZEQ1dEdZamtr?=
 =?utf-8?Q?9WBdir?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N0pXODZua1NpbHFxNGFXdnB6ajM0T0xMb1B1cnBFNEEyTkhSWFZRSmlmMTVx?=
 =?utf-8?B?d0plTGNMVERDMmZob0g0YlV3OVIxeVRvdElXeUdlcDJtN2dMQVlsUE9BUThG?=
 =?utf-8?B?dzNsdUNPK0ptbUZGajJIT3JEd2hudzdqK2JhY2MwSUViM1J0clV2bVFvbURG?=
 =?utf-8?B?ZzZYdTdoOERaUTVnelBWUCs3aDR2ZUVtc1RLYWVtQW9xYjJBbjNzMmdDNFN2?=
 =?utf-8?B?cG45YlIwNjdPZVBuQ2lJQnVQa1oxY0hWZ1o4cWlIeUhpRjBGamhJQ3h4a0xP?=
 =?utf-8?B?SHRYOHBTUCtoOEl2L2J2MlgvYWhvU0NNOEtoeGlBandZeUZQV0FnVi9jZm9P?=
 =?utf-8?B?SHB4T3NVd3pDUC9NUzJGZU0raWlJQ3ZRUUlVUnFqRHFFbkVYZFRkazVmTk9Y?=
 =?utf-8?B?K3VkT3JwTndGNEJ3TFlvK0ZrUkhkV3Z6Q3lraDIzbHNBVHVuN0plVHQyS3NG?=
 =?utf-8?B?dkY4Y29yc2h5SXJQV0ZkNEQrN3lUczU3N0plenpORzJKNU93NXFKdi8wYkJr?=
 =?utf-8?B?YXp3Y29pSkZkSWtRL3BKYlNqUUwwZWZ0MmJLeTFwdDU2K3dFYzVYT21oTSth?=
 =?utf-8?B?cGFUdjc4WUd6eExNUlFPSGg5ekdseVorMm1SZ3g2Q0xsdnQ3a3Rza2V2d0tD?=
 =?utf-8?B?UFlJSzFIb3JwMUpNM2V0cWpXUmdYNnZpNmNubU1LNHhaWEp6RDRZaDZaQzZn?=
 =?utf-8?B?V1dQcFE1c092bXphTnYvYzhWTlZsQ2pSbUczZncyRUQwcnhwY21mSWp4R0VJ?=
 =?utf-8?B?Y3MvRDBmdlN4ejd1bmt0NUdZaERXdS9BMFhZRi9FSTFCNHFzVUJiL2NPbFhC?=
 =?utf-8?B?MzlMdzZpaWlCQWU3bGJqS28wL0s2MlA4cXZpNGhFSkdXNWVlQWJsc2NTVFE1?=
 =?utf-8?B?SmJRdkU2eTBUUWhoL0tzWVpDZlptK1VYajliUTh3cEJyN1Q5VDdNRFFZZVdx?=
 =?utf-8?B?dnhtc2pxajBmNnRubytDM0c5WThaaytuWGpPQXNrRklvU2hGYXF2RFEzT3Vn?=
 =?utf-8?B?UnNESTdscTUwZEJBSjJUNGFuY25DNVJuMElTbndVZmdyRFpOZ3dIenowTTNM?=
 =?utf-8?B?UUVUSS9RU0o2UHdsZ1c5NXVkWVhVdis5MUgxRklWMXlkOCttakRHYVBhTE1G?=
 =?utf-8?B?NThMT1Y5dEMzSDdQTzBBWUg2VDBya2gwYnM4S2ZrbGh5TTN3THZFVWtHVk9y?=
 =?utf-8?B?S1RBWnY4QThQNzh5amtYLzlLNnFGaHIwZXV3N1pvWGlOR1FJQm0xc1ZuUUFw?=
 =?utf-8?B?TldOSTk0VHlXN3RyaGRmdmswa05YUG9IbCtwYVpGSGd2aXlJYlJmeXVhQTVC?=
 =?utf-8?B?b2FwOFd1bFM2NjQyKzRldmdDcVpyeHE0MmFCck92OWpmZXFNSmF4ZjVYaVl0?=
 =?utf-8?B?UzRxZlNKbUwzQktSUFpzYlJuTW1ONnFBYjhDNHhuWHE5MEJrM1k3ZGhtc0JJ?=
 =?utf-8?B?Uy9IUUdKNzBuRk8ydUZ3LzBiK2pVYk9seW1CR0tpTzlSMEk5Y0JVR0lVcVRQ?=
 =?utf-8?B?UzZ5RnZ3c0ZEWTJ5VHFTRHoyTFE5dEZ2WmZSZXFoUkEzWjM3WElIVGNyb1Zp?=
 =?utf-8?B?clVaZUtZYndoWDA4bjBvNXZZZjBKaFh1dThZV01lSlZBNEhQYy81US9vV3B5?=
 =?utf-8?B?a21WL3ZVMTFOK25ZaTRKZXNGeG9hd2paT0F0RjNKTkVvYUFsT1M3TGh1YVRo?=
 =?utf-8?B?Y3lseFo3Z1Q4QU04eGd2K3lCeE1oZ2hDUG1mSWs0YnJxeW41V1JsaVh5djNv?=
 =?utf-8?B?d1d2ZW9wR3hLanR5SlA1M3A5eloxSThkVm13anIyQXhvZ2ZzRlBWd1ZsT0Rv?=
 =?utf-8?B?M1R4K3hEdythUWdBWXNCQmNZUDhENGwrMmNZaTl4eFRiaWdNeXA2SWdTYjl2?=
 =?utf-8?B?T2xpVGZMY3ZoVnFXckdOdjBwalArVGhPa1JJQnY2WEZMMEJQZVVZUGdmcDhj?=
 =?utf-8?B?cno5eE95OTU1djVxeXpUMzlUdjNvUkluYU9IOFQ2RXU5b1graXRQYU00Mnh4?=
 =?utf-8?B?UWxVWTZYRFE5blcrOEoyVGFrT3d0VHplM2puYzJQM1NZc3VuZWZCQm0xam12?=
 =?utf-8?B?UENYeUNzWU1FaVNtSkE4Y3ZVS05zTTNJTVNaK2piMm9oZzlyTWNXY1lYZVJm?=
 =?utf-8?B?Y3UxczgzWWxIS3BnaXBrOGp0VCs5cjB1UEJ3ZWtyZTY5Wk9NNm5CbjNjMTcw?=
 =?utf-8?Q?s6aTAzw+vJFSjG6h9EOF40k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3C9783A314E5242B30FAC0BE29D55AE@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5b6539-3dd3-4e5b-80e4-08de22940c77
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 09:07:19.2290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 72WZwAV55ZFaGuuWFOYiIoqxaqrJ5eVJlXGylfxZV1Qymy75PYXXNoS2eif/BQCmtA/z+zSXC+HfMq9Sq/+9nLSxBXqAPiwU6h9NQD6w578=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7238

T24gMTMvMTEvMjAyNSAzOjEzIHBtLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBPbiAx
My8xMS8yMDI1IDA3OjAxLCBYdSBZaWx1biB3cm90ZToNCj4+IE9uIFRodSwgTm92IDEzLCAyMDI1
IGF0IDEyOjQzOjU0UE0gKzA4MDAsIEtoYWlydWwgQW51YXIgUm9tbGkgd3JvdGU6DQo+Pj4gVGhp
cyBwYXRjaCBzZXJpZXMgYWRkcyBkZXZpY2UgdHJlZSBiaW5kaW5ncywgZHJpdmVyIHN1cHBvcnQs
IGFuZCBEVFMNCj4+PiB1cGRhdGVzIHRvIGVuYWJsZSBGUEdBIE1hbmFnZXIgZnVuY3Rpb25hbGl0
eSBmb3IgSW50ZWwgQWdpbGV4NSBTb0MuDQo+Pj4NCj4+PiBUaGVzZSBjaGFuZ2VzIGFyZSBpbnRl
bmRlZCB0byBlbmFibGUgRlBHQSBwcm9ncmFtbWluZyBhbmQgbWFuYWdlbWVudA0KPj4+IGNhcGFi
aWxpdGllcyBvbiBBZ2lsZXg1LWJhc2VkIHBsYXRmb3Jtcy4NCj4+Pg0KPj4+IC0tLQ0KPj4+IE5v
dGVzOg0KPj4+IFBhdGNoICMzIGRlcGVuZHMgb24gICJhcm02NDogZHRzOiBpbnRlbDogQWRkIEFn
aWxleDUgU1ZDIG5vZGUgd2l0aCBtZW1vcnkNCj4+DQo+PiBUaGVyZSBpcyBubyBwYXRjaCAjMyBu
b3cuIFNob3VsZCBiZSBQYXRjaCAjMiA/DQo+Pg0KPj4+IHJlZ2lvbiIgZnJvbQ0KPj4+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC8zMzgxZWY1NmMxZmYzNGEwYjU0Y2Y3NjAxMDg4OWI1NTIz
ZWFkODI1LjE3NjIzODc2NjUuZ2l0LmtoYWlydWwuYW51YXIucm9tbGlAYWx0ZXJhLmNvbS8NCj4+
Pg0KPj4+IFRoaXMgcGF0Y2ggc2VyaWVzIGlzIGFwcGxpZWQgb24gc29jZnBnYSBtYWludGFpbmVy
J3MgdHJlZQ0KPj4+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L2Rpbmd1eWVuL2xpbnV4LmdpdC9sb2cvP2g9c29jZnBnYV9kdHNfZm9yX3Y2LjE5DQo+Pg0K
Pj4gR2l2ZW4gdGhhdCwgQERpbmggTmd1eWVuIGNvdWxkIHlvdSB0YWtlIHRoZSBzZXJpZXMgaWYg
eW91IGFyZSBnb29kPw0KPg0KPiBUaGlzIHdhcyBuZXZlciB0ZXN0ZWQsIHNvIHNlcmllcyBjYW5u
b3QgYmUgdGFrZW4uDQo+DQo+IE5BSywgQWx0ZXJhIHNob3VsZCB0ZXN0IHRoZSBjb2RlIEJFRk9S
RSBzZW5kaW5nIGl0IHRvIHVwc3RyZWFtLCBub3QNCj4gYWZ0ZXIgd2Ugc2F5IGl0IHdhcyBub3Qg
dGVzdGVkLg0KPg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQpJZiB5b3UgYXJlIHJl
ZmVycmluZyB0byB0aGUgY29kZSBiZWluZyB0ZXN0ZWQgb24gdGhlIEFnaWxleDUsIGl0IHdhcw0K
dGVzdGVkLiBJIGV2ZW4gdGFrZSB0aGUgbWVhc3VyZSB0byBhZGQgdGhlIGRlYnVnIHByaW50IHRo
ZSBpbiBpbml0IHRvDQpzZWUgaWYgdGhlIGZhbGxiYWNrIGlzIHdvcmtpbmcsIHdoaWNoIGl0IGRp
ZC4NCg0KT2YgY291cnNlIEkgdG9vayBjbG9jayBtYW5hZ2VyIHBhdGNoIGZyb20gRGluaCdzIGNs
b2NrIG1hbmFnZXIgZHJpdmVyDQpmb3IgQWdpbGV4NSBoYXZlIGxvY2FsIGRlZmNvbmZpZyBpbnN0
ZWFkIG9mIHVzaW5nIGRlZmF1bHQgZGVmY29uZmlnIGZvcg0KdGVzdGluZyB0aGUgY29kZS4NCg0K
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzkzMjZlZTY2Y2I4ZTMzYzBmZTgzYTI0ZTlhMWVm
ZmM4ZGEyNTJmZjIuMTc2MDM5NjYwNy5naXQua2hhaXJ1bC5hbnVhci5yb21saUBhbHRlcmEuY29t
Lw0KDQpBcmUgeW91IHJlZmVycmluZyB0byBkaWZmZXJlbnQga2luZCBvZiB0ZXN0Pw0KDQpUaGFu
a3MuDQoNCkJlc3QgUmVnYXJkcywNCktoYWlydWwNCg0K

