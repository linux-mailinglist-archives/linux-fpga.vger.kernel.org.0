Return-Path: <linux-fpga+bounces-1413-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C19C340D6
	for <lists+linux-fpga@lfdr.de>; Wed, 05 Nov 2025 07:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 07523349181
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Nov 2025 06:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48502C08B1;
	Wed,  5 Nov 2025 06:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="GXhFVJXY"
X-Original-To: linux-fpga@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010035.outbound.protection.outlook.com [52.101.46.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A630A2BF005;
	Wed,  5 Nov 2025 06:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762324155; cv=fail; b=tRumJX3esrxmWabW43VIcSTYlUd/TVy/TcPRjBT65vXJE8jFV/5x4PjUU1a3v2xh5i9ZuxHGHwkRr/p5+czm8SdG1GkDHRMDgsXDngip44kztiabPC81eI/vkk0VYzHO5wRj+4hMTYWMq5B4TTgTM1U+VhtVk5TS/TX7ONcRR+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762324155; c=relaxed/simple;
	bh=7CcqvmnPtlk9DTzJwdueqIPEvJVfRNzMs6g2LNKbkeA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ldpkMqe/bodhwXWF+l6GycSt8mG6IUT8EueptlFW5c5rDwpSBX8hCWgzQ/SqFOAQTLzuUQo5hBghOD3cV4xV6JP1Vfa9U20W7sqPWBCOf+VYLuc46jmePPNtQpux1EcDU5eJTILvAjPcrE9rIblGxD4mewAjhgcS/sgRyWHMfIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=GXhFVJXY; arc=fail smtp.client-ip=52.101.46.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vY1HKozHusVd3YeEQMcECtUnvQ56cFucCNoZoMdhydWDXISOKwGCxxQIIgwwW2EEI3DDZ5RfKg9lv4tsr4aCBSr2yKwx39KMCgSgqQ06W5d/xrY/4J2kLrrp46GbU6JzrgaNxxcs+9aWs8Yugd6DtF/qULFU8Vp7OcJ7S3j0Zk8Jx70CM81o8UrM9TXq1o4CGGo9CUA+QZvtpkGR9vtDYzWsNSIiGL/PK6yuG95T/LxS8AEVQHCqQ6MQwrV+ICTYKT6/gMiWfpJ0cBe1VwlupXwt9g4DyW6iq0HcGhlnGh6l8mUtktPb4LjIxiUuG9bfbdShY8jaBsciHZASHut+OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CcqvmnPtlk9DTzJwdueqIPEvJVfRNzMs6g2LNKbkeA=;
 b=tU60EiOqO280P4feauYmWxTpZn8BL1LWMF0pZTulZCRzCxH9uECNdgWQrIWMItrvuBxWiCjy8uHLPYth56CpfJS8HvW2I+RQyphouGrhr770JUsM5MYBI6pZFBdxufMGz7CZrL+7m48AvAySWAOEEO5hgU0UhQHqfGuKqLdIoDnXT6SuaeMrG9lGsmUix7bFZnF3GhW1w6pxl44g5TdxJMGZAm06XeunYtH6+WnjNAT2HYkqn/4LgopqQtHvDrB66NQxWWkiPd/oleWgBqkZTtwFYK3DY50qdFe31+/8VDRd6wS6Qdl+cwQVvqaKKwfRbG8OOghZFLH/3h6pToWXKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CcqvmnPtlk9DTzJwdueqIPEvJVfRNzMs6g2LNKbkeA=;
 b=GXhFVJXYoBWJi0GWB48zk+xm7o9FZ1iRZaGQwZsFOnbG3jW3KJ+DlafkuDByUWe9ouccvfmZQVs1cVQoHrmikUlE0Y6E0i5CneCGJUfOVf+o2zIIPIi+DZWfZLDxWDOF1oiqDlCeP7WTBT/8w+8z1mGLsqZG86qfgMSfPledUgULMJZTsWea1L4OGK67k1iWhqYl3CX2CraFjXCsfigF13ZamplMaqBPSa+HT3738vs7+qBr43TKVmWsVAjqJJ2gV/8j985wXofEnZQHM7bEmVcw4ke/ODVlSeCocWIE7FMYzcRq6sns9ZWH8WePb1onCS7hpjCO0rIYSzZbWW4ZSQ==
Received: from PH0PR03MB5893.namprd03.prod.outlook.com (2603:10b6:510:32::6)
 by CH2PR03MB5319.namprd03.prod.outlook.com (2603:10b6:610:93::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 06:29:07 +0000
Received: from PH0PR03MB5893.namprd03.prod.outlook.com
 ([fe80::d003:bc08:7968:c605]) by PH0PR03MB5893.namprd03.prod.outlook.com
 ([fe80::d003:bc08:7968:c605%6]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 06:29:07 +0000
From: "Murugasen Krishnan, Kuhanh" <kuhanh.murugasen.krishnan@altera.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix
	<trix@redhat.com>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND][PATCH 1/1] fpga: altera-cvp: Limit driver registration
 to specific device ID
Thread-Topic: [RESEND][PATCH 1/1] fpga: altera-cvp: Limit driver registration
 to specific device ID
Thread-Index: AQHcSQdScshRD7uhMk6/atg3+IQOL7TgqgYAgAL+4wA=
Date: Wed, 5 Nov 2025 06:29:06 +0000
Message-ID: <6a74af58-3b9b-4a8d-a10f-abbcd545083b@altera.com>
References: <cover.1761764670.git.kuhanh.murugasen.krishnan@altera.com>
 <0b6877dd7422e8c797bb42bf071fd85cf8a0af09.1761764670.git.kuhanh.murugasen.krishnan@altera.com>
 <aQhrYucpkGBWI2zL@yilunxu-OptiPlex-7050>
In-Reply-To: <aQhrYucpkGBWI2zL@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB5893:EE_|CH2PR03MB5319:EE_
x-ms-office365-filtering-correlation-id: 06154761-cf59-4b5e-89d2-08de1c349f4d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eFQ5WHlEWVVBNks0ZjA0enlNeGRNMmxxQ09DSi9LTi9xR0VBWVJESkpGY2Q1?=
 =?utf-8?B?STFuWlgvdklwSU5jZ29QcUxtOE9CcTlaMTRPRWFNUTFPVUxCcXI1dG9sMW85?=
 =?utf-8?B?OElkbWVWcmtBbzBlOVpTSnNyN01nWTRPMzN2aWRMVERZVDlMelFlWXlGejJu?=
 =?utf-8?B?T2F6bnZlYnk4cmsrTkkrUmY5UVl0Z0hqck0zQjBQY0hKalp5cW1Sc1VkZ3dP?=
 =?utf-8?B?dnp6TEJwNVo2YUZRRFg4L2RPWjZyb0wvOUp6VEp6alcyRFBTWWk5WUhaNWkr?=
 =?utf-8?B?dC81UHhqRHVPd1JsUXRCNWFCRm9ON0oyYisyS1piUUtXTEZJTThwemtBSG1Q?=
 =?utf-8?B?ZW9WeGx6cHlBUmRoOFZJUmpVLzJVMFdaMi9WUHU3dnAzZ2FsSHphazd4M3BW?=
 =?utf-8?B?QnFTb2Fic1A4alZFblRoNUFCSm5ucm9qYlVDcytCWWFIeUk0SFpmMHRSdFh4?=
 =?utf-8?B?dmMvNXdHdjhObEx4OWVhWU56VEtsRmtNdU1QWkxNTVJwRHB1OUpPc0ptd1Jt?=
 =?utf-8?B?Rmk5U1BHd0o0TFo3eGhJZ1hQbVFGTm1JTitjZnZMazhYQ2ttck1Ia0llZHFC?=
 =?utf-8?B?WW1kdEdMN3ppNFdqQk9helplaWdHU2xwV0tVMS9wRjhPWFJMSTZ6RzdSZ0FD?=
 =?utf-8?B?OFhLWTNRR1lWdWhxSDlRM3hsa3B5UkpCd3hYWkRRc3duYm5nVUFSNzdRWEIz?=
 =?utf-8?B?VUpkVDVibUJjVFVEUEFiZWV3aWxFSldJSHBRSnJxdFdFOFJVeUhXczM3Y1Ax?=
 =?utf-8?B?S2ljZnlpYkRKOGxtcVJiMG1mV0xMVCsxQ21nakozQm9IWjR6S04yWVZQcUEw?=
 =?utf-8?B?VzNUU3FtSTdJZXljbzd0N3IreWxDd2htR0dnc2dyK3NwUjhaR3E4UHd2ZUJZ?=
 =?utf-8?B?ZGxlWnNWei9GYnd0bWsyd0Y3NkJJeEN2M1VWZFMwWUN4cUpMcmRSNWtKL2pF?=
 =?utf-8?B?bUdFRTNpVTNHWDJhdnBHRndBWmFTdmszSWIxNEp0RytXNVA5N0N5bDMvUkpJ?=
 =?utf-8?B?Sm1KMkNLYmpxUDc3WU5VRlRUeEdqOG5hcE4xSnlHWnZSUVYzcVllK2NVYUVa?=
 =?utf-8?B?NmpvMTd4ZXpXRHMzSmJDSHVnZ3p2QWk1dkZvSlFDakVHNmdzTmZCdE40QmFK?=
 =?utf-8?B?bkhsT3p2c1lEQlY4Wm5mbk4vc05LNGNoUkFKaHhHV1pLbjlEMkNYaHRyTm9U?=
 =?utf-8?B?R1J2VUtickYxdU5NTXFCUnFtS0pYUlhlSDJsbHE4TmVMbkg4b3M5amE1TlFH?=
 =?utf-8?B?NzllWXZjelJiTkh6ZkMzVTcxN0QvNFlDeVlHd2duVURQdkptWVh2UDBhYVJG?=
 =?utf-8?B?UDlRRWJtN3J4RXF5RUZDOE5JM3ZIZWVFeXhLUnZYQ0tiU2t3d3p5bnowdUdq?=
 =?utf-8?B?Vk03MEFCbkhPem1saUNGYjhFTkw3aGNHUjBQZUdWN09BMzViSXQ2NTlucGlh?=
 =?utf-8?B?SjBlSWRrWlhKVTI3OWRaK29saXBXMW9wcDBPYW5XbWRUYTZKd01wRmxROFZN?=
 =?utf-8?B?U1ZlbVlFazdhTHJiR1lmaWltTmxmSys2KzY3Qm5iNDk1SkVCdTJVb1UyUHk5?=
 =?utf-8?B?OGVLbEt5aFlQUmZqQ0xEQWo1dkdDSXdvRDdOb2VrMjhBV0x6T09qYmQwdU5n?=
 =?utf-8?B?MFF0bGQ5ZDBHcWJiN1YzNHBUdGlENFQySGRVQ3dDNEpWK05keUxveWJUNkox?=
 =?utf-8?B?MGRwbGJXV1Q3RnVqUFNnMW1CMkl0RHQ0OGdRT251QXFhQjZDYUJ2aFA0WlNI?=
 =?utf-8?B?T0x4NmQ3ZVpjemZkeEkxc3Bqd280YjhxWCs3eTU5V0liVjl0RW9leDhzWnE1?=
 =?utf-8?B?eFMxYnFJZ1paZEp4Slh1MWIvc0pUYjhSM2pRdUN6bUJSTzJQTVlpNjNFekto?=
 =?utf-8?B?eUZjcGczazdQRjJUZDdXcVRWYlo0Tlg4TWpsbDcxUVJzN0E4cXlMeGs3bEtS?=
 =?utf-8?B?d3BmVjFvenFxSkhzbXovajQ0L0paejN0SDF3clIzN1Jib0gzY2pLQ1ZKdTFW?=
 =?utf-8?B?Wk9IR3BTNTdWamQ2UDhzZ3RMUTM4a2pKTXkzdzUyTVcyZG95bi9lR1pYcFFB?=
 =?utf-8?Q?Z16jQV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB5893.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NW1Ua0FoUnRsNmkxMWEwbkhDNE9kaHJZNzR5U041ekhKWlpSOGw4UmExMGhQ?=
 =?utf-8?B?SmJFRHBzVlF1QUpMNDBnVnFBUi9qNEdTSDFvWnlGNVY2ejBCalFnMlp1MG9F?=
 =?utf-8?B?d3RDc2pzd3JOdVZPdUNrVS9wR0Y0VlNxYTdERHZNNHBWZmlOSnl2ZkQ1ZUJC?=
 =?utf-8?B?VG5GSzY0VDR6M0dvOVVuUXRCOHZZMGl5dklGRDNZaDFPOTZaOHRDdGFIVXFv?=
 =?utf-8?B?RENxQVRtZVEveW5jMUxQN09tRG9HSkVPbjlEckJrNVpLdEUwKzBlSFZjdU5G?=
 =?utf-8?B?c2ZjMjY5YkNndVJmMExKRmRPK09oMzdXYmtmZ1dSNnpNVVE4RWpJWmlwd3Z3?=
 =?utf-8?B?Rjd5emZkS3E2ZVVMWE5YUzlDSStSbkozbHh2S0NqTVlzT2g2M2tJS3VDVkZm?=
 =?utf-8?B?V285WHB3cHE4WFQrSDlEN0c4UVVYcmlDV2hFYWtTMVVlOElwbDBoOHZoaVNY?=
 =?utf-8?B?K1pOVlVXR2dkR1d2UW9oMFBpWTNneWlKZ1Rzd0JjWVk4TlR5bTZ2bUZmbjM2?=
 =?utf-8?B?UlpJZkZwNXlHMng4N05WWUdTZ2l3a3NDNG9zYUx3NXJHNUlvTkpHNGlrTnp5?=
 =?utf-8?B?VUxqdHpXcEZhd3JQT2pmbFNzZnBRV1hjRlRncG5FMFBpQjJ2b1ZRTi9COVRv?=
 =?utf-8?B?UFZLcEFRUDhjMDBjNm1nT1MyNGdLZG5Za1NDWVBZRFhFRGNXc2hEcXdwcHBG?=
 =?utf-8?B?RWpieXhJTUZPZ1JSUmE1Wk10T3JVaW15WGxyRytzU3hUbmljanhBdllobWJD?=
 =?utf-8?B?ODhPNXZQZjgvYkVJeGZIVDhTdmU0eTBlWnRpbWl5bUZoQTBKTUZkZHdubXcx?=
 =?utf-8?B?M0NVbDIvcVY0Y1hjT3g0eWEyVC8rN0JSeUVuTitqakI1YlZWUXpXTkpFSktB?=
 =?utf-8?B?TFlxWTFKUFh1SEh6MGQ4dlhaVnZSdWRJYWptWFYwUDk3dENYRzlmSHFaMi9P?=
 =?utf-8?B?Ny9FckRSQTJPeTEvUURVam5nQmpUTjdqYlVPQ0VwRkUyM0xLZVNnY0N6UzFi?=
 =?utf-8?B?bis2UjlOOGEybWpnK0haT2JQb284UXkwandyazFZR0I5bEZ3bDFmMHU0TmtF?=
 =?utf-8?B?NzVTMTlTcnZ3djlmMDJJZDA4cmZ3YmY3Q2owNE5uV0syTGxMU1dFbEFhRDBi?=
 =?utf-8?B?SkNidEMvQmZEQ1ZIZU90NkhhWkRzcjFBcDg3WGZHOVRyRkVkMGRVUHY2Mlp6?=
 =?utf-8?B?cDk0MHpTUmFSZlBKdDkyUHB1NUkwdzNJRzdpcGFId2M5YTBGVXZMdnAxV2hT?=
 =?utf-8?B?bWtJMkh2eWpQeU1GMktUREh0VDlaZ2p6VDFDNG9ITHF6VFVPaUluZ3c2Mkh5?=
 =?utf-8?B?VHFEM0ZHZVZ0RDF3S28xeCtXaHl2eWxtSEdiTHQ2aGJEeTVtekdxTk1CME9I?=
 =?utf-8?B?SXVQdDNGMi8wdXhUbGRPRzhFSGVWWXpVWXpvbEJuM2pIclBGSjB3NU1WUktx?=
 =?utf-8?B?ai9pMld0N3FPN1hzaUxrVnR2QWlKQy8vQlZQU1lTQW9mYUtiL2lHYWxQcXFQ?=
 =?utf-8?B?dW9uWWc5RjRCQVRETmRKWCt6VlUzQ2pmbjFoUStZQ3MrN1FXekdCb1g2MDRF?=
 =?utf-8?B?OUpEQmtKbTRUd1hkNTBnYVlhR2JiRWxDLytnc0NlZlA1YTh4NG0zZHVpYkFR?=
 =?utf-8?B?NDMzazl6NERsaGl0ZjVkWWtCOE9oNnpSLzVhdGY0TjZqUFdkR0JCQ2E3a2Er?=
 =?utf-8?B?Tkp2TWlCTVdCdjhxcmxYKzFmT2R4N0RnSmdlRmU5VjVhRUNwb1VLb0QyNjI1?=
 =?utf-8?B?VThZSXlIN0hRaEtxUkZXb2ZNeVdTZnVFcFZXYVgrY0luTEJJeHJXcWtPVWh3?=
 =?utf-8?B?R25LT1BQd0J6cTNVYjJXVFBKeGtGU0Z3Z0xVQUlSY2VQdUdnT1ZFOEU5ZjFt?=
 =?utf-8?B?WEltS3RtNUFyRjNabDJ3S2pDTWh4SFM2U3FJSVBIOUczYXAyczhBRXk4bTVn?=
 =?utf-8?B?dlJSL2hKZ2N1NUVQY2FWbzlpaU52akp0VVVkT05pNEROdWtNbTBrM1ZUUkw2?=
 =?utf-8?B?eXRZdTFrclYvaEltWklsWkxOcy9JVGlGVlo1OElGVjl0WXJORzJ0Ny9BRlc3?=
 =?utf-8?B?cjd2dDNxOGcwcVlWOUpIUkZNOUpKbUhhbGZ3M3o4M1QxYW91bkczSlZEWlhU?=
 =?utf-8?B?cFNtQVV0QjZnajQ3S0o1TDAvRFQxYXkvZkdRTmxXSTBmNld4c2V1K0VpemtU?=
 =?utf-8?Q?HcU3WNFug4Y9DvWFIIHOiMtE+zw6tAzYgrUj+Am6AOih?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D052232ABEAE964093412D7723A26D4B@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB5893.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06154761-cf59-4b5e-89d2-08de1c349f4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 06:29:06.9667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CSXAeukLJr1BfxJmg0oqH5zrbXzvEswQaPrabQg7iYWtGE3C6kU4lYrgjNOGLNCPzxx/urymcoW393wIhX3E6sldaFS9wF8RjNY5+w0pm5gyhfhDjIdSbbqcl+Jhg8FY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5319

T24gMy8xMS8yMDI1IDQ6NDQgcG0sIFh1IFlpbHVuIHdyb3RlOg0KPiBPbiBUaHUsIE9jdCAzMCwg
MjAyNSBhdCAwMzowNTo0NEFNICswODAwLCBLdWhhbmggTXVydWdhc2VuIEtyaXNobmFuIHdyb3Rl
Og0KPj4gRnJvbTogIk11cnVnYXNlbiBLcmlzaG5hbiwgS3VoYW5oIiA8a3VoYW5oLm11cnVnYXNl
bi5rcmlzaG5hbkBhbHRlcmEuY29tPg0KPiANCj4gSXMgdGhpcyB5b3VyIGZpcnN0IHBvc3Q/DQo+
IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNTAyMTIyMjM1NTMuMjcxNzMwNC0x
LWt1aGFuaC5tdXJ1Z2FzZW4ua3Jpc2huYW5AaW50ZWwuY29tLw0KPiANCj4gUGxlYXNlIG1hcmsg
dGhlIHBhdGNoIHYyIGlmIHRoaXMgcGF0Y2ggaXMgZm9yIHRoZSBzYW1lIGlzc3VlLiBBbmQgcGxl
YXNlDQo+IGZpcnN0bHkgcmVzcG9uc2UgdGhlIHRhbGsgYW5kIG1ha2UgY2xlYXIgYWxsIHByZXZp
b3VzIGNvbmNlcm5zLCByYXRoZXIgdGhhbg0KPiBqdXN0IHNlbnQgdGhlIHBhdGNoIGFuZCBsZWZ0
Lg0KPiANClRoYW5rcyBZaWx1biBmb3IgeW91ciByZXZpZXcuIFllcyB0aGF0IHdhcyB0aGUgZmly
c3QgcG9zdCwgaG93ZXZlciBJIGRvIA0Kbm90IGhhdmUgYWNjZXNzIHRvIG15IEBpbnRlbCBlbWFp
bCBhZGRyZXNzIGFueW1vcmUgYW5kIGhhZCB0byByZXNlbmQgDQp0aGlzIHdpdGggYSBiZXR0ZXIg
Y29tbWl0IHRpdGxlIGFuZCBkZXNjcmlwdGlvbiBmb3IgY2xlYXJlciBleHBsYW5hdGlvbiANCm9m
IHRoaXMgcGF0Y2guIEFwb2xvZ2llcyBmb3IgdGhlIGluY29udmVuaWVuY2UuDQoNCj4+DQo+PiBU
aGUgQWx0ZXJhIEN2UCBkcml2ZXIgcHJldmlvdXNseSB1c2VkIFBDSV9BTllfSUQsIHdoaWNoIGNh
dXNlZCBpdCB0bw0KPj4gYmluZCB0byBhbGwgUENJZSBkZXZpY2VzIHdpdGggdGhlIEFsdGVyYSB2
ZW5kb3IgSUQuIFRoaXMgbGVkIHRvDQo+PiBpbmNvcnJlY3QgZHJpdmVyIGFzc29jaWF0aW9uIHdo
ZW4gbXVsdGlwbGUgUENJZSBkZXZpY2VzIHdpdGggZGlmZmVyZW50DQo+PiBkZXZpY2UgSURzIHdl
cmUgcHJlc2VudCBvbiB0aGUgc2FtZSBwbGF0Zm9ybS4NCj4+DQo+PiBVcGRhdGUgdGhlIGRldmlj
ZSBJRCB0YWJsZSB0byB1c2UgMHgwMCBpbnN0ZWFkIG9mIFBDSV9BTllfSUQgc28gdGhhdA0KPj4g
dGhlIGRyaXZlciBvbmx5IGF0dGFjaGVzIHRvIHRoZSBpbnRlbmRlZCBkZXZpY2UuDQo+IA0KPiBT
byBjb3VsZCB5b3UgcGxlYXNlIGFuc3dlciB0aGUgcHJldmlvdXMgY29uY2VybiBoZXJlPw0KPiAN
Cj4gRG9lcyBkZXZfaWQgMHgwMCBjb3ZlcnMgYWxsIHN1cHBvcnRlZCBkZXZpY2VzPyBEbyB5b3Ug
aGF2ZSBhbnkgRE9DIGZvcg0KPiB0aGlzPw0KPiANClllcyBpdCB3aWxsIGNvbm5lY3QgdG8gYWxs
IHN1cHBvcnRlZCBBbHRlcmEgRlBHQSBkZXZpY2VzIGNvcnJlY3RseSwgDQp0aGVyZSB3YXMgYSBi
dWcgcHJldmlvdXNseSB3aGljaCBjYXVzZWQgaW5jb3JyZWN0IGRyaXZlciBhc3NvY2lhdGlvbiAN
CndpdGggdGhlIHVzZSBvZiBQQ0lfQU5ZX0lELiBMaW1pdGluZyB0aGUgZHJpdmVyIHJlZ2lzdHJh
dGlvbiB0byAweDAwIA0KYWxsb3dzIHRoZSBkcml2ZXIgdG8gYXR0YWNoIHRvIHRoZSBpbnRlbmRl
ZCBBbHRlcmEgRlBHQSBkZXZpY2UgY29ycmVjdGx5IA0Kc2luY2UgdGhlIEZQR0EgZGVmYXVsdCBh
ZGRyZXNzIGlzIDB4MDAuIFVzaW5nIFBDSV9BTllfSUQgY291bGQgDQpwb3RlbnRpYWxseSBhbGxv
dyB0aGUgQ1ZQIGRyaXZlciB0byBhc3NvY2lhdGUgdG8gb3RoZXIgUENJIGRldmljZXMuDQoNCj4+
DQo+PiBSZXZpZXdlZC1ieTogRGluaCBOZ3V5ZW4gPGRpbmd1eWVuQGtlcm5lbC5vcmc+DQo+IA0K
PiBJIGRpZG4ndCBzZWUgd2hlcmUgdGhlIHRhZyBpcyBmcm9tLiBHZW5lcmFsbHkgd2UgZG9uJ3Qg
cHJlZmVyIGENCj4gUmV2aWV3ZWQtYnkgdGFnIGZpcnN0bHkgYXBwZWFyIGZyb20gb3RoZXIgdGhh
biB0aGUgcGVyc29uIG5hbWVkLg0KPiANCj4gVGhhbmtzLA0KPiBZaWx1bg0KPiANClRoaXMgcGF0
Y2ggd2FzIHJldmlld2VkIGludGVybmFsbHkgYnkgRGluaCBhbmQgdGhlIHRhZyB3YXMgYWRkZWQu
IFNob3VsZCANCkkgc2VuZCBhIHYyIHBhdGNoIHdpdGggdGhpcyAiUmV2aWV3ZWQtYnkiIHJlbW92
ZWQ/DQoNCj4+IFNpZ25lZC1vZmYtYnk6IEFuZyBUaWVuIFN1bmcgPHRpZW4uc3VuZy5hbmdAYWx0
ZXJhLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IE11cnVnYXNlbiBLcmlzaG5hbiwgS3VoYW5oIDxr
dWhhbmgubXVydWdhc2VuLmtyaXNobmFuQGFsdGVyYS5jb20+DQo+PiAtLS0NCj4+ICAgZHJpdmVy
cy9mcGdhL2FsdGVyYS1jdnAuYyB8IDIgKy0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZnBnYS9h
bHRlcmEtY3ZwLmMgYi9kcml2ZXJzL2ZwZ2EvYWx0ZXJhLWN2cC5jDQo+PiBpbmRleCA1YWYwYmQz
Mzg5MGMuLjk3ZTlkNGQ5ODFhZCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZnBnYS9hbHRlcmEt
Y3ZwLmMNCj4+ICsrKyBiL2RyaXZlcnMvZnBnYS9hbHRlcmEtY3ZwLmMNCj4+IEBAIC01NjAsNyAr
NTYwLDcgQEAgc3RhdGljIGludCBhbHRlcmFfY3ZwX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2
LA0KPj4gICBzdGF0aWMgdm9pZCBhbHRlcmFfY3ZwX3JlbW92ZShzdHJ1Y3QgcGNpX2RldiAqcGRl
dik7DQo+PiAgIA0KPj4gICBzdGF0aWMgc3RydWN0IHBjaV9kZXZpY2VfaWQgYWx0ZXJhX2N2cF9p
ZF90YmxbXSA9IHsNCj4+IC0JeyBQQ0lfVkRFVklDRShBTFRFUkEsIFBDSV9BTllfSUQpIH0sDQo+
PiArCXsgUENJX1ZERVZJQ0UoQUxURVJBLCAweDAwKSB9LA0KPj4gICAJeyB9DQo+PiAgIH07DQo+
PiAgIE1PRFVMRV9ERVZJQ0VfVEFCTEUocGNpLCBhbHRlcmFfY3ZwX2lkX3RibCk7DQo+PiAtLSAN
Cj4+IDIuMjUuMQ0KPj4NCj4+DQoNCg==

