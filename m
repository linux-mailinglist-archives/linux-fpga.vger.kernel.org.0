Return-Path: <linux-fpga+bounces-1090-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 160B9A4BF91
	for <lists+linux-fpga@lfdr.de>; Mon,  3 Mar 2025 12:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F093F1889A86
	for <lists+linux-fpga@lfdr.de>; Mon,  3 Mar 2025 11:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB7A20CCD9;
	Mon,  3 Mar 2025 11:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k/KVqWjO"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA431F891D;
	Mon,  3 Mar 2025 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741003043; cv=fail; b=Z6i5E9Bbl5apQjoELagRyMLHA1acygbS7n+CT0+Lwn0V/Dds4MkwDzMllMFZ5jQnaEYc8LIRjNorTof+CV5J7mVpmlvcO1WvfhKEpXj7tHJcZcIEYv07lFi7mHk+neSzKDsXuyX/A4DOow2yV6NINzTDp2ogNbFzJ6SzyeoWJc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741003043; c=relaxed/simple;
	bh=D+X1Iet3i9n+IT/qbV/ClhjrOxxU9+DMbNxjb9OYO1Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X5i+YMz2eK1vfcUf0n2NJVBwn7pQm96XTM34WmUVn3KNoDpakdDmzQ11zBHVJHc9xK+VjpivZGQ3Zvi2Om1eLTTA+v09WBSbgrYnoHYl4F3+hUmWu2V+LrKiLEDziitBDzAxOYOULYOyCd4jzcruyLOoDwsAzrW75bxf4PUIme4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k/KVqWjO; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LduzGwJ+ywdzykiawJ7vz644s/xXIw7RFLkkBdgnxTeDzhsiYjjd7Hhs2QWnd1Y8pTTUJXnGIu5fYa9CDIDccY5NEALvP+4DZZPxZo988H+RQacVsqZPha1Iern3cTlUyr804SDD9d+pCIkEfIic0z/JEFdE32Uy1AH1zC9MWvNPL5HcyIXmLo2oejukoCpEhkZ4EiGfi+UDuIUY+Bsn28PmUhNclc1VvuL8hvXQwJ51RSujr56tmwKo2voIjCLb3TenJ23RMx626siA3mxgxwnGXxzCQVac3kaMnKAg52rPxIhWrs0xcsj6ifqWachkpiRAGgA4vgC9Lt7OIiDgBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+3M+4C1feb+BUNEPlMBq8Wdtgx+cG+y+1e70IPrfBY=;
 b=sUTabhNZN1tMdW1D2uviBC90R2usHQzHarJrL6OZ8K/uouEBubpU45wesDxq8vam2tFEwAnMMFNsdCfG+ABWBo+32oSviV47nfbfD2mKmRku98SX7RLhiozeMTBPRgaGpL4vY5YPhy0Tc399jnMpiC10m/D01GUE8dog9mzIm2rpfe4kdwiLlx6epfyfsoAHYbxVmJ5FJLbtZTm20UIlrYgoP1hC5xgFuk9BjihP503isbOc9JZI392Ju9NYr80DOPUc4qCXwpkm8KJtqMir7XVFi6bxbolIVh94x11xQtCS/vtNTBAMJWUWe535WyEE9iJIzOa4Uc7Oli4bQFKazw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+3M+4C1feb+BUNEPlMBq8Wdtgx+cG+y+1e70IPrfBY=;
 b=k/KVqWjOSsQka26XJdtcreiCk5MCBgDBw2N+ntPhs3TgCTUw+wHQKPzWc8uEajREcmTQvcCjLSOENdI7BccOvsopMdELhPRKbEVUGmrxTFue8eySpD8Djv5P8a8seFnSaitJEH+qB1j5RqSTIvDz8yirVfQ86T65zceAxSJCLJ0=
Received: from DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) by
 IA1PR12MB6602.namprd12.prod.outlook.com (2603:10b6:208:3a2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.25; Mon, 3 Mar 2025 11:57:19 +0000
Received: from DS7PR12MB6070.namprd12.prod.outlook.com
 ([fe80::b847:e013:8f93:f6e4]) by DS7PR12MB6070.namprd12.prod.outlook.com
 ([fe80::b847:e013:8f93:f6e4%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 11:57:19 +0000
From: "Manne, Nava kishore" <nava.kishore.manne@amd.com>
To: "iansdannapel@gmail.com" <iansdannapel@gmail.com>,
	"linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
CC: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun
	<yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, =?iso-8859-2?Q?Rafa=B3_Mi=B3ecki?=
	<rafal@milecki.pl>, Aradhya Bhatia <a-bhatia1@ti.com>, "open list:OPEN
 FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: RE: [v4 3/3] fpga-mgr: Add Efinix SPI programming driver
Thread-Topic: [v4 3/3] fpga-mgr: Add Efinix SPI programming driver
Thread-Index: AQHbicYG9R/dKaVbOEakaw6xd74lqbNhS1iQ
Date: Mon, 3 Mar 2025 11:57:18 +0000
Message-ID:
 <DS7PR12MB607055136A599EE9A1895414CDC92@DS7PR12MB6070.namprd12.prod.outlook.com>
References: <20250228094732.54642-1-iansdannapel@gmail.com>
 <20250228094732.54642-4-iansdannapel@gmail.com>
In-Reply-To: <20250228094732.54642-4-iansdannapel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=99e19a79-bad3-4318-97b3-0e78a3651e9e;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-03T11:28:54Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6070:EE_|IA1PR12MB6602:EE_
x-ms-office365-filtering-correlation-id: 0dca5598-d80a-4f29-d9f9-08dd5a4a8c98
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?2IHeTGjRrcARCV+pyMvw9rxNW13/ennkhrOU/GjpJkOHlPlVsGHUzJ4YD5?=
 =?iso-8859-2?Q?TD8SBOB3dIhWprNHUuiEvfKl5uA7NHoKM1PlTPD4JIQzrPIDR0Zc3p10u3?=
 =?iso-8859-2?Q?VtM6geT2QGlDpNkzPWdc8OAmFqcZLwy8KWqZ7SWtcqbzNm1JLgHZFwNn4n?=
 =?iso-8859-2?Q?4fhN4gjcVkt+TCvB4O1xYh5pHxrfNoZ/mNtTDPuozdpVy/Qnczh/MWjkCa?=
 =?iso-8859-2?Q?9hlWMX7v+92oYWI5XKwdVwC1dbN9yqfm8bPfdGPJvOu/YRn9MvsYqUWlu2?=
 =?iso-8859-2?Q?Ky6/vqVtUr6siUyx3fLKVZn7Ab4bGbnz7+E0dIufxD+X38xdluKruJ2A62?=
 =?iso-8859-2?Q?zX30yGt2QKorYpj7lUnv3ZXnnaAeOWMa5mIJJ6UPhKSvrJi8sNuLIRiSHe?=
 =?iso-8859-2?Q?JKaL2szF6ZhRelflag3RYzR0pO1JxwCKQqKlliVTp33WAght7BYnSGT4LM?=
 =?iso-8859-2?Q?P4V+fbsQoiZCKAhwwNIUbQU9XVMr2Gn9adkeXsa9PQ/PJHzjLsWkHWzzOe?=
 =?iso-8859-2?Q?xM5AEGTnsvpmUcQb6BpZhd+MqrsDKTrDPntOco8cXcAGeNSiQilvbac1nk?=
 =?iso-8859-2?Q?pWJGOt8V25R3b9ilkh7asTvU6nnKg6+xriQOAJ7ZLhAI62ejsPikG+/W7j?=
 =?iso-8859-2?Q?GSAf+hyvuFN8vmcNQhFebIgfpOI/vwVkEM+dSN8cvYsxAwlILk1Q8xiDkN?=
 =?iso-8859-2?Q?GzBz5SzfdU1UneGoUIC/KTI5OF79Nq7JPWrLWgR6KIOsX3UI8Scmso5pw/?=
 =?iso-8859-2?Q?8aSFo4YNxgS47v5tLsX4ZD+dNh7ut2jx5L51MpQfJIW3IePMqBxLFjimth?=
 =?iso-8859-2?Q?0q3va3JchVOuVHSBZ/HDseYW9w5d5kl9c0WvE0VqscC4SCZxFLmz3rIUV5?=
 =?iso-8859-2?Q?4Vc49Rrn1sgpavJsSLahxjugLNLGo7ox+D9Nv+mXi1s6mIfXnvXi4sKjZ9?=
 =?iso-8859-2?Q?R8cIH7dE8nKiQM0Qu0GldYjdKa5PNmz0xgKcg7X9dD5ouiS3OJRBrOld9n?=
 =?iso-8859-2?Q?cXs7JY6BCyUVSu5x5MGBwGciJZDw+Omp0/EQHv+fCXKgKMvDI8SH4G6I4f?=
 =?iso-8859-2?Q?yvyEpBPUKAKdhnAVuLZ3tMHHAg5cHmwvHLdew991RRb3SoY5dcYyOmbcYw?=
 =?iso-8859-2?Q?KyXKyDHC6ga3xzVYkqNKpSkxoXekk2bi0T0Dh49aZBsUyheQkjN5DLY0bz?=
 =?iso-8859-2?Q?+1DGxl081pecY2wM+TDT/lDce5m2GXxVUNu9tEhlNezcIcH2z+93yQaFJm?=
 =?iso-8859-2?Q?r5oCyzazhEco6rVKVSn+CcPMXva1p6zA5Sj9d1cMFbtPyoC/dSLkeC2JLz?=
 =?iso-8859-2?Q?ejH0LCaLtbuJ/HPw9w+yjQpJqg5T2fLW0w8KcFFDWIYqWvX4bEg37aiI+0?=
 =?iso-8859-2?Q?j8VYmwBnP18kgz27C68sxBFR9+xvXjdUKSJIMxtEgPmszBgusBvetKzklf?=
 =?iso-8859-2?Q?etSv5BehR0hxNjxSzh4f9rUtuFgRy38NL5YBb69uvNo0faUxWm5zohbr2U?=
 =?iso-8859-2?Q?V2GrqccGZ4s1hCXHGhbwyy?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?SGfp7i//rNEpTx8vI4QRFGPmWa/YZCrKB59+K6sSIoqUVyszqqiIfqN9DM?=
 =?iso-8859-2?Q?mitl4cjtK8wyg30c8cjSP554DSiy6AAl5tDG+bwN3mKtjpsp99eaAVH0Zb?=
 =?iso-8859-2?Q?btGoZV8YCX9tjk0rRm4AVSgoSBfwIQmtGjgF5f20UYlYV1kVWhVn3hxLh1?=
 =?iso-8859-2?Q?Ll2KRA68SaWYsV5P0adCiXkpE1cg9Ybdek6gSOBm/3TyqMLj04656gx5Ut?=
 =?iso-8859-2?Q?UhqaqD7AMTnruWqvhMHwkwUUqa7QdlL8CgzuMaaLtfxE9/PyWeKL2XrNi0?=
 =?iso-8859-2?Q?N/vjERlwVu5BTxDNOCbrDSRu3hVN/eHuszFlm8XAA9WebsmrzNFOyahSRb?=
 =?iso-8859-2?Q?Y8wQGeoFUNY3PhRXhRxEcB1Y2gg8i0Vlu+FMQ4EHh+h7bIsVNfZ5j/9rBD?=
 =?iso-8859-2?Q?Wj0aRfpfyL9uafoZQrq3voIeMsdkEvGVP7yatTwRxOia96DHSLSAbuEoie?=
 =?iso-8859-2?Q?xThIw3EsxSpiv72N4XBuu4dK5Fik2MaY/+dhSuovKdPnrTEHVJVyic2Fce?=
 =?iso-8859-2?Q?vS9wvcJc1Oa6nSUHY3Sx2JEyPnlQC2xtfNaKZI+HAeGG095nQNNex/uEox?=
 =?iso-8859-2?Q?GcgTyp1rBdHaaWyNEwkLOAC4igA1xPgv/m/eBhJgxNL0lZqKKSogWjNUt9?=
 =?iso-8859-2?Q?qaRlOWXmiFbA1fvT3HbSAQnWZwkgJyicBYJB8mYbyW80zXHroXog4hQKCz?=
 =?iso-8859-2?Q?nkf9stz1eycejtv4s3+u2/kTEBwrcwm1rnKm/1PYAbG16kT3Iofl/NPolO?=
 =?iso-8859-2?Q?tEWm/WA4HmQyXAKvjPtZo5ef8Yj/NNEQ9LSoQ1oFEUW+V6QwEqghE9F0Nb?=
 =?iso-8859-2?Q?BTG2tn69Dq1xkUrlUGA0LUkWKXxJaATww4xs3Ngj1dEqFaZaNx+suqYGfy?=
 =?iso-8859-2?Q?5v0XyRSJwgoFAD2nWXUsOBD/fBG+vc67qfMAMJDj7JxrQZFks2CSgs6zME?=
 =?iso-8859-2?Q?tGbIuEDFJRCPinEODq8OmvtdCfLK+fwKqCzn4mD2H+fS6ACwYXWXMGWS+u?=
 =?iso-8859-2?Q?Wh+G6izMZj7Vfjaeul0jX78TDclCQOSkzO9wvHakmiolxHKq+8HFCshS+5?=
 =?iso-8859-2?Q?bV+jIyy/vYbsTQYxqsl1KKJ0sKdzXpA3m/MeVyUHQPI+iZqn0hwU4ul7Dz?=
 =?iso-8859-2?Q?/LwoGnGdYfj7o+aAZ4RGEXf553fwKuNkxZVEGeEhlfe4TSZl2n094TwZMo?=
 =?iso-8859-2?Q?QJCp63WScpZVoinoIQIhG+IkvkqN/1EGkmFJ+q2up/AIXg3BZRbKYA69rY?=
 =?iso-8859-2?Q?nwosJB9/1+ZxTo3FxKHGKVBHarZwdRQOoV93kyQTDWE5b4l0eve+prvC1R?=
 =?iso-8859-2?Q?ItxyawaUFfE8FrutF5SC5FoMZJigIBHW25a/ktVBJRQxotQfaaYD4rIwTl?=
 =?iso-8859-2?Q?NRED8j8AErat/0uxo04B7VsGCzFtzyunRocJcbXygOCCOzT4uWW7Dxj20z?=
 =?iso-8859-2?Q?OoxkT/D1/uGIQ1jTXWdQAojPpzeTXaZiIQzzG8NRD+IKmMmx2PM6zEU4Lz?=
 =?iso-8859-2?Q?smqnoFrPiJVVvsTzc0TNHmkh+Ees5G7YLOHqQeeaIgOhLMmVLys7VZabMm?=
 =?iso-8859-2?Q?7eF3exgm7WBeodSxbRWOlDU10EXLPK1xa1NyzV5q+a1K79I6o96BRREYRM?=
 =?iso-8859-2?Q?m21OasVvF73+0=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dca5598-d80a-4f29-d9f9-08dd5a4a8c98
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 11:57:18.8937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4MZNV8POe33IsOLmldIzJkE1U1Jk/JVyeYMNr1AOjDvsBNbQbIMICLnJeFUkTiAQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6602

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: iansdannapel@gmail.com <iansdannapel@gmail.com>
> Sent: Friday, February 28, 2025 3:18 PM
> To: linux-fpga@vger.kernel.org
> Cc: Moritz Fischer <mdf@kernel.org>; Wu Hao <hao.wu@intel.com>; Xu Yilun
> <yilun.xu@intel.com>; Tom Rix <trix@redhat.com>; Rob Herring
> <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Neil Armstrong <neil.armstrong@linaro.org>; Jonath=
an
> Cameron <Jonathan.Cameron@huawei.com>; Rafa=B3 Mi=B3ecki <rafal@milecki.p=
l>;
> Aradhya Bhatia <a-bhatia1@ti.com>; Ian Dannapel <iansdannapel@gmail.com>;
> open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> Subject: [v4 3/3] fpga-mgr: Add Efinix SPI programming driver
>
> From: Ian Dannapel <iansdannapel@gmail.com>
>
> Add a new driver for loading binary firmware to configuration RAM using "=
SPI
> passive mode" on Efinix FPGAs.
>
> Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
> ---
>  drivers/fpga/Kconfig      |   7 ++
>  drivers/fpga/Makefile     |   1 +
>  drivers/fpga/efinix-spi.c | 212 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 220 insertions(+)
>  create mode 100644 drivers/fpga/efinix-spi.c
>
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig index
> 37b35f58f0df..b5d60ba62900 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -83,6 +83,13 @@ config FPGA_MGR_XILINX_SPI
>         FPGA manager driver support for Xilinx FPGA configuration
>         over slave serial interface.
>
> +config FPGA_MGR_EFINIX_SPI
> +     tristate "Efinix FPGA configuration over SPI"
> +     depends on SPI
> +     help
> +       FPGA manager driver support for Efinix FPGAs configuration over S=
PI
> +       (passive mode only).
> +
>  config FPGA_MGR_ICE40_SPI
>       tristate "Lattice iCE40 SPI"
>       depends on OF && SPI
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile index
> aeb89bb13517..adbd51d2cd1e 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_FPGA_MGR_TS73XX)               +=3D
> ts73xx-fpga.o
>  obj-$(CONFIG_FPGA_MGR_XILINX_CORE)   +=3D xilinx-core.o
>  obj-$(CONFIG_FPGA_MGR_XILINX_SELECTMAP)      +=3D xilinx-selectmap.o
>  obj-$(CONFIG_FPGA_MGR_XILINX_SPI)    +=3D xilinx-spi.o
> +obj-$(CONFIG_FPGA_MGR_EFINIX_SPI)    +=3D efinix-spi.o
>  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)     +=3D zynq-fpga.o
>  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)   +=3D zynqmp-fpga.o
>  obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)   +=3D versal-fpga.o
> diff --git a/drivers/fpga/efinix-spi.c b/drivers/fpga/efinix-spi.c new fi=
le mode 100644
> index 000000000000..07885110a8a8
> --- /dev/null
> +++ b/drivers/fpga/efinix-spi.c
> @@ -0,0 +1,212 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * FPGA Manager Driver for Efinix
> + *
> + * Copyright (C) 2025 iris-GmbH infrared & intelligent sensors
> + *
> + * Ian Dannapel <iansdannapel@gmail.com>
> + *
> + * Load Efinix FPGA firmware over SPI using the serial configuration int=
erface.
> + *
> + * Note 1: Only passive mode (host initiates transfer) is currently supp=
orted.
> + * Note 2: Topaz and Titanium support is based on documentation but
> +remains
> + * untested.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/spi/spi.h>
> +
> +struct efinix_spi_conf {
> +     struct spi_device *spi;
> +     struct gpio_desc *cdone;
> +     struct gpio_desc *reset;
> +};
> +
> +static void efinix_spi_reset(struct efinix_spi_conf *conf) {
> +     gpiod_set_value(conf->reset, 1);
> +     /* tCRESET_N > 320 ns */
> +     usleep_range(1, 2);
> +     gpiod_set_value(conf->reset, 0);
> +
> +     /* tDMIN > 32 us */
> +     usleep_range(35, 40);

Use macros instead of hardcoded values.

> +}
> +
> +static enum fpga_mgr_states efinix_spi_state(struct fpga_manager *mgr)
> +{
> +     struct efinix_spi_conf *conf =3D mgr->priv;
> +
> +     if (conf->cdone && gpiod_get_value(conf->cdone) =3D=3D 1)
> +             return FPGA_MGR_STATE_OPERATING;
> +
> +     return FPGA_MGR_STATE_UNKNOWN;
> +}
> +
> +static int efinix_spi_write_init(struct fpga_manager *mgr,
> +                              struct fpga_image_info *info,
> +                              const char *buf, size_t count)
> +{
> +     if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
> +             dev_err(&mgr->dev, "Partial reconfiguration not supported\n=
");
> +             return -EOPNOTSUPP;
> +     }
> +     return 0;
> +}
> +
> +static int efinix_spi_write(struct fpga_manager *mgr, const char *buf,
> +                         size_t count)
> +{
> +     struct efinix_spi_conf *conf =3D mgr->priv;
> +     int ret;
> +     struct spi_message message;
> +     struct spi_transfer assert_cs =3D {
> +             .cs_change =3D 1
> +     };
> +     struct spi_transfer write_xfer =3D {
> +             .tx_buf =3D buf,
> +             .len =3D count
> +     };
> +     struct spi_transfer clk_cycles =3D {
> +             .len =3D 13,  // > 100 clock cycles

The .len =3D 13 is based on documentation stating?
Consider using macro.

> +             .tx_buf =3D NULL
> +     };
> +     u8 *dummy_buf;
> +
> +     dummy_buf =3D kzalloc(13, GFP_KERNEL);

Same - use macro

> +     if (!dummy_buf) {
> +             ret =3D -ENOMEM;
> +             goto fail;
> +     }
> +
> +     spi_bus_lock(conf->spi->controller);
> +     spi_message_init(&message);
> +     spi_message_add_tail(&assert_cs, &message);
> +     ret =3D spi_sync_locked(conf->spi, &message);
> +     if (ret)
> +             goto fail_unlock;
> +
> +     /* reset with asserted cs */
> +     efinix_spi_reset(conf);
> +
> +     spi_message_init(&message);
> +     spi_message_add_tail(&write_xfer, &message);
> +
> +     clk_cycles.tx_buf =3D dummy_buf;
> +     spi_message_add_tail(&clk_cycles, &message);
> +
> +     ret =3D spi_sync_locked(conf->spi, &message);
> +     if (ret)
> +             dev_err(&mgr->dev, "SPI error in firmware write: %d\n", ret=
);
> +
> +fail_unlock:
> +     spi_bus_unlock(conf->spi->controller);
> +     kfree(dummy_buf);
> +fail:
> +     return ret;
> +}
> +
> +static int efinix_spi_write_complete(struct fpga_manager *mgr,
> +                                  struct fpga_image_info *info)
> +{
> +     struct efinix_spi_conf *conf =3D mgr->priv;
> +     unsigned long timeout =3D
> +             jiffies + usecs_to_jiffies(info->config_complete_timeout_us=
);
> +     bool expired =3D false;
> +     int done;
> +
> +     if (conf->cdone) {
> +             while (!expired) {
> +                     expired =3D time_after(jiffies, timeout);
> +
> +                     done =3D gpiod_get_value(conf->cdone);
> +                     if (done < 0)
> +                             return done;
> +
> +                     if (done)
> +                             break;
> +             }
> +     }
> +
> +     if (expired)
> +             return -ETIMEDOUT;
> +
> +     /* tUSER > 25 us */
> +     usleep_range(30, 35);

Same - use macros.

> +     return 0;
> +}
> +
> +static const struct fpga_manager_ops efinix_spi_ops =3D {
> +     .state =3D efinix_spi_state,
> +     .write_init =3D efinix_spi_write_init,
> +     .write =3D efinix_spi_write,
> +     .write_complete =3D efinix_spi_write_complete, };
> +
> +static int efinix_spi_probe(struct spi_device *spi) {
> +     struct efinix_spi_conf *conf;
> +     struct fpga_manager *mgr;
> +
> +     conf =3D devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
> +     if (!conf)
> +             return -ENOMEM;
> +
> +     conf->spi =3D spi;
> +
> +     conf->reset =3D devm_gpiod_get(&spi->dev, "reset", GPIOD_OUT_HIGH);
> +     if (IS_ERR(conf->reset))
> +             return dev_err_probe(&spi->dev, PTR_ERR(conf->reset),
> +                                  "Failed to get RESET gpio\n");
> +
> +     if (!(spi->mode & SPI_CPHA) || !(spi->mode & SPI_CPOL))
> +             return dev_err_probe(&spi->dev, -EINVAL,
> +                                  "Unsupported SPI mode, set CPHA and CP=
OL\n");
> +
> +     conf->cdone =3D devm_gpiod_get_optional(&spi->dev, "cdone", GPIOD_I=
N);
> +     if (IS_ERR(conf->cdone))
> +             return dev_err_probe(&spi->dev, PTR_ERR(conf->cdone),
> +                                  "Failed to get CDONE gpio\n");
> +
> +     mgr =3D devm_fpga_mgr_register(&spi->dev,
> +                                  "Efinix FPGA Manager",
> +                                  &efinix_spi_ops, conf);
> +
> +     return PTR_ERR_OR_ZERO(mgr);
> +}
> +
> +static const struct of_device_id efinix_spi_of_match[] =3D {
> +     { .compatible =3D "efinix,trion-spi", },
> +     { .compatible =3D "efinix,titanium-spi", },
> +     { .compatible =3D "efinix,topaz-spi", },
> +     { .compatible =3D "efinix,fpga-spi", },
> +     {}
> +};
> +MODULE_DEVICE_TABLE(of, efinix_spi_of_match);
> +
> +static const struct spi_device_id efinix_ids[] =3D {
> +     { "trion-spi", 0 },
> +     { "titanium-spi", 0 },
> +     { "topaz-spi", 0 },
> +     {},
> +};
> +MODULE_DEVICE_TABLE(spi, efinix_ids);
> +
> +static struct spi_driver efinix_spi_driver =3D {
> +     .driver =3D {
> +             .name =3D "efinix-spi",
> +             .of_match_table =3D efinix_spi_of_match,
> +     },
> +     .probe =3D efinix_spi_probe,
> +     .id_table =3D efinix_ids,
> +};
> +
> +module_spi_driver(efinix_spi_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Ian Dannapel <iansdannapel@gmail.com>");
> +MODULE_DESCRIPTION("Efinix FPGA SPI Programming Driver (Topaz/Titanium
> +untested)");

If untested, it might be useful to mark them as experimental in Kconfig.

Regards,
Navakishore.


