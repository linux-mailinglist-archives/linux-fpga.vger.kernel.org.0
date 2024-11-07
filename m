Return-Path: <linux-fpga+bounces-924-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8569C0F80
	for <lists+linux-fpga@lfdr.de>; Thu,  7 Nov 2024 20:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03991C229BC
	for <lists+linux-fpga@lfdr.de>; Thu,  7 Nov 2024 19:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98716218327;
	Thu,  7 Nov 2024 19:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b="i+KhzXCc";
	dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b="k8NRYtO4"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mx0b-000e8d01.pphosted.com (mx0b-000e8d01.pphosted.com [148.163.143.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EFF217F5B;
	Thu,  7 Nov 2024 19:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731009579; cv=fail; b=ulHG1j5G/WW+LSE5LEFEcsQgEz3BDEmgE/2NfZuVJqkXLbfdrZhGQ64QLaVyExrcI7RZUAd0J721NsACFBxwIojHNORPUtq1vp0uBAwp4FtcafSQmgbe0J8QmoLP7gwEsnIXWhF91RJbnWyqMWrgIKS9Wk9VMQmIFEsJqBsCpBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731009579; c=relaxed/simple;
	bh=1AcmjzO/JCqP3KldPyfpiqAMtbIMacv2Xd6sehm9nk4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FDe3FGKKCsm5TQVT7bpY+RKHs33QjE+a26g+IPxz1gfVYMtvoD+ZRT9mV7xZj4mPBHE7giIExShwr94WjTCcLVanNsv7xuCNUQFA5WqPb3X1j6X5+uIKKgbOQ9QsGKJEPS8+weSvuEURzb1jpPIx9TL2RDgo9Qs/NSxvvCopyaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=selinc.com; spf=pass smtp.mailfrom=selinc.com; dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b=i+KhzXCc; dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b=k8NRYtO4; arc=fail smtp.client-ip=148.163.143.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=selinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=selinc.com
Received: from pps.filterd (m0136174.ppops.net [127.0.0.1])
	by mx0b-000e8d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7IwhBx010344;
	Thu, 7 Nov 2024 11:59:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=sel1; bh=1AcmjzO/JCqP3KldPyfpiqAMtbI
	Macv2Xd6sehm9nk4=; b=i+KhzXCcOsS4KQc3ZWNvD/0k+sxtUcw2pf+ze3r59Cx
	Yw6VnKRQe/nHJwDxaLX4SsygICncobUqyJLj01VNfRwT0g3Mg5b/xfmxk89ghiUM
	HH5zvT0LHFNDHa64geTq1Ms3yNeyrUWphULY/oOjpJm7rMo/fEehqbVTfaUrHirp
	ZcFnnkxBEZB00ijskkV1//vKO+4dU2u72TE0vsUGLvWAfpP0IRL1aaphObXavrDY
	gMl/6GoLk3dxt4cPNKEKD+IcQYuZVecrDJPD8vvq8Kq13b8QobKAcguC4TZNQlgm
	eHK8cf4lK4IKge9h5/tJiRZxc43+y6vi+wpdutvSqWA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 42s0wq85wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 11:59:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEExxL86XDz8XHQn1LhbwilCFYDqHje/sWKF1lieNjDQcIg7p/R6UCn7v1Cjr4ARNICiSx7dAfBro4LKUlvqy22+9kxhxDw+AsUYlfQrmJ8W4NVkzlRaUxSkAPds8ZdNnUHEEXsGVRStftSIgya8v46DqiQBsWuuc+979qwpoI+5ryEWdupHhS3PyNlvn5A2aVAlAalih2HKw6IP1SsvVdeNvrsZylEP/mpkbH1rm0HF2zA/a9EKVdfsIcCkPaGWIXNDhtGrCNIAEVy45FBmFV0vmOPLxZ0mSD09+5yF3OxyNG7K2DPG34Bb3fEAmjJECdjURR8YwZS6DIhYuVk2iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AcmjzO/JCqP3KldPyfpiqAMtbIMacv2Xd6sehm9nk4=;
 b=XclKICis0OdgUQnVlXA0OoTRGEZ6x68rbA1Pe3Vn3xcCJ1Xh84rr6JzJatLvvo7obI4PLyBBaGcXIhrcGko/xZI7W65IqFfKKQ2oQpic4fxf4IdQyQ9LZ7kdnX3KJklfPPJQY0jhWVWp/TJAQnjNJINwTT+fmypYCrUvz1bnsb2xwXW6nyZ6fdqz2VbmAio0tC7WUPGniJRbNHlqVL08ma/TBFVLvoibG74Ayja5EZrla72i2a5KMi/0ixc9Y4DwmekUATQC1C23nFV0+Obj454wooe0YeNt+cx3XzPP8kLiiRCWgT3ufpQo9RkSmf8LN97F3hxo93ZBYWeAnUdxpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=selinc.com; dmarc=pass action=none header.from=selinc.com;
 dkim=pass header.d=selinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AcmjzO/JCqP3KldPyfpiqAMtbIMacv2Xd6sehm9nk4=;
 b=k8NRYtO44gS5JDkbKNnqOOiXGpNm1EHl6tQjNSd/MawwvkKIZF9nxnc2YhlHHz5sBKxAn4JPRnOv8A9RGXs9e8x6cvFf0kYdConAlxpiOPxfTYQysAH6U5qLbcWbrFfsP0twPucT5mRedXEifQf81xWSlXs3EG7IBjcbuS+kKyS6TGslqInRoTGRyCPXBLaw+i34OnU2xW015sxrA3Ip5r1QdJXY0iRUbRaQc5G2rZTym9nbtHFUVx5NUoVtCaNMv8EGFf26OoN3pBxuS4xKN+H4ywwkX52cqo3WTNYXp7sxg0DOLYtD2pcRZnWUQDrjCUV6BftyILzIp4Owacqk6Q==
Received: from PH0PR22MB3809.namprd22.prod.outlook.com (2603:10b6:510:297::9)
 by SJ2PR22MB3773.namprd22.prod.outlook.com (2603:10b6:a03:501::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 19:59:27 +0000
Received: from PH0PR22MB3809.namprd22.prod.outlook.com
 ([fe80::dc78:5b2b:2e12:8731]) by PH0PR22MB3809.namprd22.prod.outlook.com
 ([fe80::dc78:5b2b:2e12:8731%3]) with mapi id 15.20.8114.031; Thu, 7 Nov 2024
 19:59:25 +0000
From: Robert Joslyn <Robert_Joslyn@selinc.com>
To: "mdf@kernel.org" <mdf@kernel.org>, "hao.wu@intel.com" <hao.wu@intel.com>,
        "yilun.xu@intel.com" <yilun.xu@intel.com>,
        "trix@redhat.com"
	<trix@redhat.com>
CC: "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Loading FPGA Firmware with CvP
Thread-Topic: Loading FPGA Firmware with CvP
Thread-Index: AQHbMUaAmos0kNEoZEu0BoNeRFr/zA==
Date: Thu, 7 Nov 2024 19:59:25 +0000
Message-ID:
 <PH0PR22MB38093EC891192F65DC6C76ADE55C2@PH0PR22MB3809.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR22MB3809:EE_|SJ2PR22MB3773:EE_
x-ms-office365-filtering-correlation-id: 7b6639f4-2461-4278-f67f-08dcff66ae21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?rTfyaccAxhQwi9+WCtMC/n/vdrLBu3UOisheKrooN3Oq4njIAUCXAfZPks?=
 =?iso-8859-1?Q?pJMnulcFPmHUoVksR4RV/IVCaogHPrZbYiXmFMKFRllrEMOMB2wsoo7DrC?=
 =?iso-8859-1?Q?k03E2sWNGJckpQbYotyEX6KusghpfpCQCtrvGfU0WOVwvncRl6JZ252vgK?=
 =?iso-8859-1?Q?No5AuuE33Q//iR0HjyZheMZnMf0iBMiUVfEGQ8wwM8OaytW2R5FXvwEth8?=
 =?iso-8859-1?Q?XukOtCkgvaC0vhGBaOEQ0ziqcCHnr1sJRi3rDIz8OTTVRT9mBsyDdzC3yW?=
 =?iso-8859-1?Q?cJ9EZVdrT4K4TfgMKYrbHwWvzzUUh8oveS/vuRTsGSRbxr0QmY6R1KOjm0?=
 =?iso-8859-1?Q?0tQQWwTuoIW6cLGNsGuEG7QoN5Hg+eThf5YXN6qCPnIVsqOtlfPeNEPOEY?=
 =?iso-8859-1?Q?cZGBthEZ8QXMMoHesqyZ3+JW7ePHto4JRvdSa7qLjbiM6us7/yV+xKSGcb?=
 =?iso-8859-1?Q?oCAYUQHX9iY06loh4P4caC76t7EjBaTEDV0NfwTSNxLdzoSQeh4yUa7duH?=
 =?iso-8859-1?Q?IiBfnzCNS7LXj4h1gAzMNMudsG7GzfCI75UOajlKXI+/o7McCISYwVUP25?=
 =?iso-8859-1?Q?w1kIj8aDHKcezrJ2H9eAXFMYFYntkouBUALpoOfSHa3KSKNA1Qm3ILyAoL?=
 =?iso-8859-1?Q?BX3tmsyMt2Tad840jEsbZ2uAfvWRoCqj9ATp4bDwjE7UTdJLVSslW0M8Yw?=
 =?iso-8859-1?Q?kR96cAzz+2krZ5zcoQ7FFEufB3MTApe6nRfi37jKFDwSqtSmT30EqwNafi?=
 =?iso-8859-1?Q?R5aG9DTJcjX81OnV3/G1iRz3Dzj7lPt7PG5whsitgPRxQ0tOTFdbuhFsA+?=
 =?iso-8859-1?Q?B9MN6YNu/sa7X5nwGeTt1LAf1GQh2PcY+/nbPkvjIS/nE/mC8QOMHF6KA6?=
 =?iso-8859-1?Q?4VwOHjlOIgExkTgKKELzOFEDlKD3XXNst0SSF2Bkq8X7y1RKH9B3ChYOb1?=
 =?iso-8859-1?Q?1O2AT260OktcC30xO6cYfOB+7BEESp+luykG8SXo8+N7z7W46PWriJ+8+w?=
 =?iso-8859-1?Q?MBmuT9j1WQ5wWpjqoYAoCLdF/iaF/+sK0BYPiJqCW1yFBiFXKYT8easffJ?=
 =?iso-8859-1?Q?3H8AwEIi3UqDYI0FhqnonGxVSQtUiriPDiXZX7JzgswLCBEWQbBe8GADr+?=
 =?iso-8859-1?Q?jQN4su7eyGVyTRdhPRpGO7UZn/XCdHdm3vVTs2tqmuA5khq+JnrZdHsgN9?=
 =?iso-8859-1?Q?8S+HZVW6kOv7dl+DZ9/RzkQST3u4GNqk41QZWHD3MaNq3yaZ8WrF9tnpc+?=
 =?iso-8859-1?Q?Zg0FkDtJN4bP4I4sDa8HCN6qSoPmy4MP1lfq5RpwdBEAslbWUWKypKu3wB?=
 =?iso-8859-1?Q?O50vcNI+WH8DyRxa+ynRngnRfBSHBdFTXlrsq5B/c8zrqRPzG1i/Uc22SN?=
 =?iso-8859-1?Q?PbAQgVsaUkKtKD51dgrNTSeeopSWsGsg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR22MB3809.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?gGdv9lLdrQKYUe0hFim+yloLZBF5coI7BTXiFyFD4WqkKzWSqekahJhaqT?=
 =?iso-8859-1?Q?QK4/UTrGwSQfwmp3Kv9/3T77F8aOooTZOatgVhTsiFXMLsKs/cPtso4hk+?=
 =?iso-8859-1?Q?YOhu/bi2u7GPPzkLh3N/rkh3QebU/URrA/k/GDHBzvGarhW3jkGFm1WJJG?=
 =?iso-8859-1?Q?bToFpsr98o20Swbkj5Go14Y6EpY1Quohxxkw3Zv7GRkl/aOxBM1hibEdOc?=
 =?iso-8859-1?Q?NdbbdvY6L9g1eJ08AG3+keLfKL5QUkCjk//s7YfCju+QZzj8wCX7MneSzr?=
 =?iso-8859-1?Q?WKsS49E24/x5lSgyQaktp753hmSaMMCAQ9Pz++DmVT7uGdkL6qOESq+28s?=
 =?iso-8859-1?Q?8phS+hf0Yy05KoFmfLpwtK/G9sZOKcQ3TzgQ5s2R4cBQqIDoOKxZ0I0JVA?=
 =?iso-8859-1?Q?VLBSSz/nDsf/XPCub0SmSpO4yMh1JFCrWk8LxgxK4Xxegd8Mvy61GDpliF?=
 =?iso-8859-1?Q?lCHTyDhopusYSFkqahk76G+SoVtyIyxTpcrlwIG+74IeFWqOQFniW0zNKJ?=
 =?iso-8859-1?Q?9j15UjwqnQZkwBJdfcSQ8IJXQs6Q9a68Pw0pnWKV13wZokM4YUZCy8iI5h?=
 =?iso-8859-1?Q?DjTwUrUj9StqmnvTsSn4R6MZS8EdN8ChKk9cjxiWxQiw/f/MrNbs+3rAl9?=
 =?iso-8859-1?Q?zHv+jbH2BHs0M+Trx2/Zqbx4IjDomxMpLPi6iZS/BaLA9oqulS7rWM/rcH?=
 =?iso-8859-1?Q?kOGUOv+1QyHax65p2uYRP6YXTZ8wGu07jG/8n05I5p62f48/OkDFKqc0WQ?=
 =?iso-8859-1?Q?mdVUZJ4d8SmnYNDULvOGQwc8XM+W8oVAl3mXu2WRsdKH9999mAMk/2NvtX?=
 =?iso-8859-1?Q?HhE2mYG3c85bVxraf4GAdgRQFWM2HjVjtJshCX9i9S1dafYSE3wy47FORq?=
 =?iso-8859-1?Q?KJfK52cwZA21HEL8G/osEJaZa666l/hrALN2SjYTWfz8m8snSwhyc8LuLv?=
 =?iso-8859-1?Q?OU+yPY3ev/sI80yu1kuSnrTJBCyBqk9o1ESRcf0PKqi+yW8lwoAMBrwAEu?=
 =?iso-8859-1?Q?r2o8V5QbQTT6w1pLZLJFJUUZP8qN8yjILuB1/AfO89CJXrb0b18XN+F1Pw?=
 =?iso-8859-1?Q?0KeT+43u/ElE3b6j8ZIniKMqxlFaUdGiWP1g1CLlFJX8Xn12NXHxZ0CxeU?=
 =?iso-8859-1?Q?g9qWLLtW+NYYfNBKGRV9/Vt3ZuvxWa2esj5NjJxZ/9gltm3gjjb4w6ATdf?=
 =?iso-8859-1?Q?b/0So9AORlC8BUlMsgfq6ySB4EbUo9l2KdpTMprPdt4Dh3VI5f5QtTPeE0?=
 =?iso-8859-1?Q?0orDiIg0fnN479YOynDgHLrf33Psw7vCY0O5zkBs5YOIjcmxPb/MEmkecR?=
 =?iso-8859-1?Q?+8bu1TB2/kh25Lx+pzQv9nJZ3SNv/By8MbL/jUvfifKOywMh6s6eQOWweu?=
 =?iso-8859-1?Q?YG9NqeF2kyn9kDQ1/WKSM8crwbI83SRd8dXc9H38grubJ6rVfHSAdZ0uGl?=
 =?iso-8859-1?Q?YifLVCbnT2nq7NH7B3h1RyPE7njfxR/5zsNJqxLd4Yt0USNhaYNea+xsKN?=
 =?iso-8859-1?Q?Q0bqPEpWglTXNODx/2bJy+MoZQS+RjYtrHFxcZDp0IhSK06nwBjdBA3+3y?=
 =?iso-8859-1?Q?qIv93zID9cMnKNwiScPDSbxnslYO+Z599K9osAqQDSpGXUPOlmRIrEsVXV?=
 =?iso-8859-1?Q?NFw7FvWs2pWExmvhVyT0s0BR6Ubu1BkUJQ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR22MB3809.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6639f4-2461-4278-f67f-08dcff66ae21
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 19:59:25.2448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BhtANkPcGvoOlBiI1t0IU43sJZTExCdwFXlv3HlkiYv0ggG5qL/dMILmgU2pQkaE2AGtjhDl2A+J1AiT8+RBxAmPROw59PkCx+BWiaPQanE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR22MB3773
X-Proofpoint-ORIG-GUID: ryjWBe1Gq2S8duVBRGa8LIAOPjxXqUP6
X-Proofpoint-GUID: ryjWBe1Gq2S8duVBRGa8LIAOPjxXqUP6
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 phishscore=0 mlxlogscore=730 impostorscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070157

I'm working on mainlining a driver for some PCIe devices that use an Altera=
 FPGA and Configuration via Protocol (CvP) to load the necessary firmware w=
hen the driver loads. An RFC patch of this implementation can be seen here:=
 https://lore.kernel.org/netdev/20241028223509.935-1-robert_joslyn@selinc.c=
om/T/#t=0A=
=0A=
This is implemented as an MFD driver called selpvmf that loads for the PCIe=
 device, which then creates MFD cells for the different functional componen=
ts within the FPGA. The MFD driver has a CvP implementation to load firmwar=
e to the FPGA. It was suggested by the MFD maintainer that this CvP impleme=
ntation probably belongs elsewhere. This CvP functionality also exists with=
in drivers/fpga/altera-cvp.c, but it's not exposed in a way that I can use =
from a separate driver.=0A=
=0A=
If I understand correctly, the FPGA manager system is designed to create an=
 abstract interface for loading FPGA firmware from userspace. The altera-cv=
p driver in particular will bind to any device with an Altera vendor ID and=
 let userspace load firmware via CvP. In the selpvmf case, we have our own =
vendor ID and we're not trying to let userspace load arbitrary firmware. We=
're really only trying to facilitate our driver loading the necessary firmw=
are for the device to work. Would it be acceptable for me to create a libra=
ry driver for CvP that is used by both? Or is there some other preferred op=
tion?=0A=
=0A=
Thanks,=0A=
Robert=

