Return-Path: <linux-fpga+bounces-1051-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BD0A30ACE
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Feb 2025 12:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87FD81889D57
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Feb 2025 11:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387481FAC3B;
	Tue, 11 Feb 2025 11:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MtGnGfGb"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D19F1FA854;
	Tue, 11 Feb 2025 11:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739274643; cv=fail; b=DXv1InMyRESv7pVvH9gSGlG76gVF7pwKV2n8X+SXGhh686XJBcCBQSLfstXufAaubGbrET98Kss9y0Sdw4sOtXkOzr8UcBMCSyjNGVRCq54WBL7/UWOizvzijPyaDKTe94/cpBH/ZCVSK/esnPd5DxsITNmzSG5K9coCR3CWclI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739274643; c=relaxed/simple;
	bh=6hgMWCATJFn88zCWOAhWvSFH0t/om9qxez/C99xwxiA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X1TS/RGymQf4Q72QH2ZMYzVwipgPxtJ1A4auLyoMP6DdQm0pJ2nyYecVjCrpnoj5P/7mCraPRasIYySvKhrsgtHvHKQhB1H4mJPfOG4xZTKwG3NbF4IqZ4AfBhI6GDSrDAdDL/N9XeHu/yIbfnR703Gfq59uuScDfnxfEi/fWeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MtGnGfGb; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0AZ9sWCNvfGqlHMkSnyYck5Ik8tBtmUlM7Fd2I+qIIMjATS6MOGDMSGxPpvj0T7BlSJho/txhJLxUCFNXBRRgI182CvOp3ze7Pw5cfYaXzcZrTy6vHbpryshWVwCAEGjH2Y8XGttyGXSacHtOTU12LWF93xrF0UlHbrebzNfdmawiZOdZLwE2UhXnRZ5FJ3WSo4Op1+yoKMN8of/tv4KplZhRaafH2VyKgbgwcWxV9HEmiKKjFGFYtyCKndsA5iMeupG4zb+t5qPOLkVZ5Byilf18ODdl8DnszCsS+sWgspsLicdSApYFVR6Wj3xxb2c24M0u+tWgsjKDX5+V3raw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DA2fAq6usaVOlA+0tc7A5jhZus9hF0jTtetvjeo6uo4=;
 b=vGqhQW+NDgC59cicKh+tt61AFpw+oqCDwcUNJPX/qbc6jaDcr7Fy4zizXUgT4I78fdNxcCveQ7iicwr74d+7z1KEM4/lA8kYRKU6DFAJnspV0ewBwy6xPGUXtTRhTvhzEeYP06Rkza8CqwQY5TL+uQt4fXOxZDHZWB7q0wBAhJWf5Q6XF40+tV6Q9Fz9/lggTr6mFkqNXv/9ZYH4I9kfvMzOUscAvwlN7wRJ8jEHxfBWgbpeBNQ+fvyQwhQlTOW2DmU9eb8XP01raY+W4UkFHczUhgbebjzscQeDk/cv/tHQ5oWY5JinMGnX2AzpSWDCje+owAfUOO4c5eOnvAJybw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DA2fAq6usaVOlA+0tc7A5jhZus9hF0jTtetvjeo6uo4=;
 b=MtGnGfGbGnaJbLrXz8+q45tAYjo9b3+F1d3dkYGmRDwgtqHGiZg0JByJEbFFpNiMEs8v7+nOCZx2rFzyj7aXhOnL16VkQvDdaNwClIis4QEVdno4J/kpJPfHxZ+WBEH2R0BVVuPoQusSekejnT6L4ekXycKCdKI4DvsnHuLE87w=
Received: from DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) by
 PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 11:50:35 +0000
Received: from DS7PR12MB6070.namprd12.prod.outlook.com
 ([fe80::b847:e013:8f93:f6e4]) by DS7PR12MB6070.namprd12.prod.outlook.com
 ([fe80::b847:e013:8f93:f6e4%7]) with mapi id 15.20.8445.008; Tue, 11 Feb 2025
 11:50:35 +0000
From: "Manne, Nava kishore" <nava.kishore.manne@amd.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: "git (AMD-Xilinx)" <git@amd.com>, "mdf@kernel.org" <mdf@kernel.org>,
	"hao.wu@intel.com" <hao.wu@intel.com>, "yilun.xu@intel.com"
	<yilun.xu@intel.com>, "trix@redhat.com" <trix@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "saravanak@google.com" <saravanak@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [RFC v2 1/1] fpga-region: Add generic IOCTL interface for runtime
 FPGA programming
Thread-Topic: [RFC v2 1/1] fpga-region: Add generic IOCTL interface for
 runtime FPGA programming
Thread-Index:
 AQHbKeN81itnx65szk2mzvzQ12GeBbK+H1CAgAN+t4CACOtuAIALTWAAgAmaNICADi35oPwQ/uKAhEQEFIA=
Date: Tue, 11 Feb 2025 11:50:35 +0000
Message-ID:
 <DS7PR12MB6070A5E6BB63E473C1D7028FCDFD2@DS7PR12MB6070.namprd12.prod.outlook.com>
References: <20241029091734.3288005-1-nava.kishore.manne@amd.com>
 <20241029091734.3288005-2-nava.kishore.manne@amd.com>
 <ZzwQrYeWVF6cRtgA@yilunxu-OptiPlex-7050>
 <DS7PR12MB6070AAA0C413DBF26F685207CD222@DS7PR12MB6070.namprd12.prod.outlook.com>
 <Z0Z6socXrmHQ26C0@yilunxu-OptiPlex-7050>
 <DS7PR12MB6070F3DD9119CD7955EF8AFCCD372@DS7PR12MB6070.namprd12.prod.outlook.com>
 <Z1gD7QvhSN8p6//v@yilunxu-OptiPlex-7050>
 <DS7PR12MB60706A47591D7F3CC6D41398CD062@DS7PR12MB6070.namprd12.prod.outlook.com>
 <ZBcsbTG3PaDjNzUX@yilunxu-OptiPlex-7050>
In-Reply-To: <ZBcsbTG3PaDjNzUX@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6070:EE_|PH7PR12MB5685:EE_
x-ms-office365-filtering-correlation-id: 59d2abf2-ae69-4c60-d3de-08dd4a924bac
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aGzMNLs5IANf/hlrH5My6gk1P2g8nBIDmXF8h/nWJ8rsV5lpEsN5DTIy+47m?=
 =?us-ascii?Q?1t9rNyGDJOM05YhYvVa9vQTgquvp7LK2FXJ17BQUWG17lGADqcPBIyv3ox0P?=
 =?us-ascii?Q?tAUk+c9CWxUmtlUif4j5Nxo0MvUhNG/WrhYq5SdQexi8c4LxPEebC5+DbGNq?=
 =?us-ascii?Q?eCmHQA73T03xbNIJRegx78tzYf27dIy39ErOceTcyw3PN++/T0qEopxukM2Y?=
 =?us-ascii?Q?vJVhec9q+0OKxkk3Xps15epj4T8wgBwQ4Z2NN7l7sWU9R4blb8wE+t4IMPeD?=
 =?us-ascii?Q?Hw190E/gjlZHHu1/dlXCfJ/SOX5JyY/LZ3AohCuDo9GfacKCldoCtQFrVeJn?=
 =?us-ascii?Q?mph/ZWmLJgJFPXC2mQJ0/okghpCuMr0pNGEgpKqkUOCmv/SRnc7gdzKp1/zx?=
 =?us-ascii?Q?GhL3x+pCVMuZqWcPda6d52JiZ58y+Xj2CF35mQi5DEXt7/8OybUec5pkxZue?=
 =?us-ascii?Q?DRzz+2llDtwl1/oihuR9Tf3qWx9yJEIHWKsT0O1TpD9OyKocjmQwGEabXBvJ?=
 =?us-ascii?Q?9iAvHyMfcJJO0Zij1D3CHwpPJbHmmlD9RwOkA4OblcoX9zJ8bUnMMruHbaM5?=
 =?us-ascii?Q?s0CdQi+GstAyeX9CchMyeH5IrIMW+yEEUdWHeGJXLTPC+SDqj9nSVmpSsvum?=
 =?us-ascii?Q?xidZYY76NHGUosYKs2Zwa2R/Yk0kao5RYOHsoo6v48ApNeMNUZtHfIxoAmwT?=
 =?us-ascii?Q?tg9GhnK/9WOpYMTybGn9KnryAIGtyOyVoPAIXDSapSdrdjo8E3Y7Hah6DlnB?=
 =?us-ascii?Q?olx6CYQ3Wl0d622O/QIrOIZMv2knZD7+cs3Q/OvMSgoMMpTmG2qYX6r544EB?=
 =?us-ascii?Q?FPMZO9Zd7UZnpFGMx/5KuEbnMfOI/MLv5uD1bkOtM6MKqb9NWx+OBbl2pCaT?=
 =?us-ascii?Q?ORWQKtdoh+VMOpiOdQiMAvnmYs4+k1R4TsY3ouis5C2gSi1MrXuOEjViyrfT?=
 =?us-ascii?Q?aYXtsJxaOjZrkiKMV1StkNQkEq3JwuVNv4/1YZfFGWtsRGzfFpHCPetl+wuh?=
 =?us-ascii?Q?nhT5lgPWJ8xwNr3NxExT6mcMwIdl8J0kGeLpUY4opciGtwzfRQqM4oBqZG4O?=
 =?us-ascii?Q?PUPrKlLxvZ5TkzTwAgPPyKEdco3g5vqe39mgEd/YWEEHHv2PPqwwBGvQkats?=
 =?us-ascii?Q?maFAvceFtpugrKjkXxOBY0x9BmBqrRZdc05iYkpx11f1lR0RF/tF7L/qRhUP?=
 =?us-ascii?Q?ZRvfMa3S6sBpoT3oHFyNf2YsUbwYDXfJZDaMjCceLuxKDZI625n6kMQhqyBo?=
 =?us-ascii?Q?HutXtMroSsx643NXChnkCDnUffUgYy5AUmJPkmpFh4WxHd4RmKm6CPZ4Jmk5?=
 =?us-ascii?Q?rQv7x20Xt3DYeBLhBGjYDDMywC5LzqVphvjtHUyHQl/JeZ2ypSYz3k0mgTeq?=
 =?us-ascii?Q?himo9QFAPuk2ft0+mskfYd+BB6UvA1TuKcFRvVRiZHLzcIg1gEYkXc04exFD?=
 =?us-ascii?Q?Lhm9yzRJOOLRAqhzb5MJ7IGblylhuiET?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GOIQIDgxlCsgm1xqB+g4SkVfwblR83A28OvSiWMXviDMcvXU+5JUSKWlzYTw?=
 =?us-ascii?Q?Py2kIPHhRSe9mfzmJdm4bSXh2OeD3ax3YWLuJ/j4DugT/FtGwYA15eDzWOpQ?=
 =?us-ascii?Q?r2+MWFLcqGn4WZWqlqcOpakgwJ1hNn2ClmP9MH6a2OAd9gjZSPdUlhV9cG+k?=
 =?us-ascii?Q?qZ+CUQ/VUXeVx32RF0ZxX352o9eIqNaWqMpeYBGCg/QZjgOxnkeQvaEL98AK?=
 =?us-ascii?Q?x+FCakfnepyOhmozFw3YxN0SofQkeZO6Zlm+lBoKcTyyewL0Zp20yMPAx6Ww?=
 =?us-ascii?Q?dDAkgoOKsDVsY48EHntac//71H4CSdBaij9X4mG/Ozw+89Z6pNA45nRuLCeC?=
 =?us-ascii?Q?newFpEpWsxZEsYL/S1MYOSCwetMnuVCREZzZr8ArTXyolmDyM4JDxoiBRXA/?=
 =?us-ascii?Q?/IleFyTfQ/hjKiw5O0DqcHYoNjWvZUHee7ufEBOjkuPGR4g5z1Tj8cIp0cI9?=
 =?us-ascii?Q?E+wpm2nTiN7UL4feaRQnN+QEvwlZfj6cJyEJsM6IEq0dwGsxZLEWmO8aePs2?=
 =?us-ascii?Q?Owd0aRyz/8uQ1yB5XUiu+DKQ0uOvlS9nSW/Oi3JOCuIJ0+QU1zLn+Vivkpkb?=
 =?us-ascii?Q?vMBXqxQRYqaF76gk4JRbokyunAFPJtP86Yoyegz+X+u0tms/XfEaLwgNGzge?=
 =?us-ascii?Q?FrV3cMSHH+41xvoEw5mcwgZQr5XILhvCgqV3pNjWRTJc7i1bPPQsHn7QtGQp?=
 =?us-ascii?Q?Q47ZgkAptC0omeSPlcecgRyGYAD8YOdAdpVGtOGVU8yjVgxhh+S59m8CI/nQ?=
 =?us-ascii?Q?SFhjOdDayejM890IhKOjVOfbNvX8Vz4M6AzBkLcAXKAQzd0v9c6Q3DJPB0B6?=
 =?us-ascii?Q?janFRKyJs4be6LKVzu1lmrYYMU2tGB4AvfZ62si2X8pAjJ4orDySsXqY6XPN?=
 =?us-ascii?Q?Xi3d4dC4oKjZAMMB7IhhsZMmLy90OuY99ai9s11IVK2pTPpHrnbYBLogHlTc?=
 =?us-ascii?Q?h8G+GjqzR8nZzB/ijhkWnfXvA9T0emeF5a/3khFsM1T3YL044S9sB+KnbDXh?=
 =?us-ascii?Q?KquCjszRIQyckviBBU5ieVpy0CCtYXMs2MBJiZ+39699AORk8MyFJ8jCZf8Y?=
 =?us-ascii?Q?z1hUMqIZQW3nTU6aHIPgAI1QCYz4+u41DFWrQcz5Jmd1oNxvM8DuJR2r8rPg?=
 =?us-ascii?Q?+m6e7z1aqu7WOi1Z8ZDOnbzoXp/52TbAteDzQYo9MAsCmOEr7Yfnu7XZv0L4?=
 =?us-ascii?Q?ff8d9QQyqkZGHPoUuvsmRK2AwVBqYML5Wjyb8ScCNrL06+fAsaSbBl3+nPNM?=
 =?us-ascii?Q?LCVFh67W7fk+08BAfpckWROE8eRYn4Nhu3KLGo8K/8HTixAdtiVLBxcvV0e4?=
 =?us-ascii?Q?2VxMyJs9jnzYwgzUGrw7JnCZePCHbMTPhLJhboBH2AKFKlysM2xTqrFoj6AO?=
 =?us-ascii?Q?zgGl2JNSikD5bngtZ8RBiNegrJfxkFeCm/jRP1Rl/s/1NC46cijrIicyPLDa?=
 =?us-ascii?Q?O9KZeWD/U7b+zM2TnBzTifzjzvI9AVM2nrkzeOqsNVnD+7YaGDPmSOcyAuDl?=
 =?us-ascii?Q?K1duy0GHys+Yl6Fa6/xX5CdX/1c+FWMhuTck+WsmERFn8SIXR2vdSG9oQ4yv?=
 =?us-ascii?Q?GidPWlVT4IdRPKSqn5g=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d2abf2-ae69-4c60-d3de-08dd4a924bac
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 11:50:35.1237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ak0pu22Tc4G3FM1u48zCZTqqQRqXb6RT0/f10yUW5eqnWiC7GZkKMpeOVDiCSyJe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685

Hi Yilun,

> -----Original Message-----
> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Sunday, March 19, 2023 9:08 PM
> To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> Cc: git (AMD-Xilinx) <git@amd.com>; mdf@kernel.org; hao.wu@intel.com;
> yilun.xu@intel.com; trix@redhat.com; robh@kernel.org; saravanak@google.co=
m;
> linux-kernel@vger.kernel.org; linux-fpga@vger.kernel.org;
> devicetree@vger.kernel.org
> Subject: Re: [RFC v2 1/1] fpga-region: Add generic IOCTL interface for ru=
ntime
> FPGA programming
>=20
> On Thu, Dec 19, 2024 at 09:47:12AM +0000, Manne, Nava kishore wrote:
> > Hi Yilun,
> >
> > > -----Original Message-----
> > > From: Xu Yilun <yilun.xu@linux.intel.com>
> > > Sent: Tuesday, December 10, 2024 2:34 PM
> > > To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> > > Cc: git (AMD-Xilinx) <git@amd.com>; mdf@kernel.org;
> > > hao.wu@intel.com; yilun.xu@intel.com; trix@redhat.com;
> > > robh@kernel.org; saravanak@google.com; linux-kernel@vger.kernel.org;
> > > linux-fpga@vger.kernel.org; devicetree@vger.kernel.org
> > > Subject: Re: [RFC v2 1/1] fpga-region: Add generic IOCTL interface
> > > for runtime FPGA programming
> > >
> > > On Wed, Dec 04, 2024 at 06:40:18AM +0000, Manne, Nava kishore wrote:
> > > > Hi Yilun,
> > > >
> > > > > -----Original Message-----
> > > > > From: Xu Yilun <yilun.xu@linux.intel.com>
> > > > > Sent: Wednesday, November 27, 2024 7:20 AM
> > > > > To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> > > > > Cc: git (AMD-Xilinx) <git@amd.com>; mdf@kernel.org;
> > > > > hao.wu@intel.com; yilun.xu@intel.com; trix@redhat.com;
> > > > > robh@kernel.org; saravanak@google.com;
> > > > > linux-kernel@vger.kernel.org; linux-fpga@vger.kernel.org;
> > > > > devicetree@vger.kernel.org
> > > > > Subject: Re: [RFC v2 1/1] fpga-region: Add generic IOCTL
> > > > > interface for runtime FPGA programming
> > > > >
> > > > > > > > + * struct fpga_region_ops - ops for low level FPGA region
> > > > > > > > +ops for device
> > > > > > > > + * enumeration/removal
> > > > > > > > + * @region_status: returns the FPGA region status
> > > > > > > > + * @region_config_enumeration: Configure and enumerate
> > > > > > > > +the FPGA
> > > region.
> > > > > > > > + * @region_remove: Remove all devices within the FPGA
> > > > > > > > +region
> > > > > > > > + * (which are added as part of the enumeration).
> > > > > > > > + */
> > > > > > > > +struct fpga_region_ops {
> > > > > > > > +	int (*region_status)(struct fpga_region *region);
> > > > > > > > +	int (*region_config_enumeration)(struct fpga_region *regi=
on,
> > > > > > > > +					 struct fpga_region_config_info
> > > *config_info);
> > > > > > >
> > > > > > > My current concern is still about this combined API, it just
> > > > > > > offloads all work to low level, but we have some common flows=
.
> > > > > > > That's why we introduce a common FPGA reprograming API.
> > > > > > >
> > > > > > > I didn't see issue about the vendor specific pre configuratio=
n.
> > > > > > > They are generally needed to initialize the struct
> > > > > > > fpga_image_info, which is a common structure for
> > > fpga_region_program_fpga().
> > > > > > >
> > > > > > > For port IDs(AFU) inputs for DFL, I think it could also be
> > > > > > > changed (Don't have to be implemented in this patchset).
> > > > > > > Previously DFL provides an uAPI for the whole device, so it
> > > > > > > needs a port_id input to position which fpga_region within
> > > > > > > the device for programming. But now, we are introducing a
> > > > > > > per fpga_region programming interface, IIUC port_id
> > > > > should not be needed anymore.
> > > > > > >
> > > > > > > The combined API is truly simple for leveraging the existing
> > > > > > > of-fpga-region overlay apply mechanism. But IMHO that flow
> > > > > > > doesn't fit our new uAPI well. That flow is to adapt the
> > > > > > > generic configfs overlay interface, which comes to a dead end=
 as you
> mentioned.
> > > > > > >
> > > > > > > My gut feeling for the generic programing flow should be:
> > > > > > >
> > > > > > >  1. Program the image to HW.
> > > > > > >  2. Enumerate the programmed image (apply the DT overlay)
> > > > > > >
> > > > > > > Why we have to:
> > > > > > >
> > > > > > >  1. Start enumeration.
> > > > > > >  2. On pre enumeration, programe the image.
> > > > > > >  3. Real enumeration.
> > > > > > >
> > > > > >
> > > > > > I agree with the approach of leveraging vendor-specific
> > > > > > callbacks to handle the distinct phases of the FPGA programming=
 process.
> > > > > > Here's the proposed flow.
> > > > > >
> > > > > > Pre-Configuration:
> > > > > > A vendor-specific callback extracts the required
> > > > > > pre-configuration details and initializes struct
> > > > > > fpga_image_info. This ensures that all vendor-specific
> > > > >
> > > > > Since we need to construct the fpga_image_info, initialize
> > > > > multiple field as needed, I'm wondering if configfs could be a so=
lution for the
> uAPI?
> > > > >
> > > >
> > > > A configfs uAPI isn't necessary, we can manage this using the
> > > > proposed IOCTL
> > > flow.
> > > > The POC code looks as follows.
> > >
> > > I prefer more to configfs cause it provides standard FS way to
> > > create the fpga_image_info object, e.g. which attributes are visible
> > > for OF/non-OF region, which attributes come from image blob and can o=
nly be
> RO, etc.
> > >
> > > Of couse ioctl() could achieve the same goal but would add much more
> > > specific rules (maybe flags/types) for user to follow.
> > >
> >
> > Agreed. Using ConfigFS is preferable because it provides a
> > standardized filesystem interface for creating and managing the fpga_im=
age_info
> object.
> >
> > The proposed new user interface is outlined as follows:
> >
> > # Mount ConfigFS filesystem
> > mount -t configfs none /sys/kernel/config
> >
> > # Upload Configuration and Load the Bitstream for the Targeted FPGA Reg=
ion.
> >
> > Configuration File Upload:
> > Upload the configuration file containing the necessary metadata or
> > settings required for configuring the FPGA region. This file may vary
> > based on the vendor and includes important details specific to the vend=
or's
> requirements.
> >
> > Vendor-Specific Callback:
> > A vendor-specific callback function extracts the relevant configuration=
 data from the
> file.
> > The format and contents of the configuration file can differ between
> > vendors. The callback then initializes the struct fpga_image_info,
> > ensuring all vendor-specific requirements are satisfied.
> >
> > Device-Specific Considerations:
> > For Open Firmware (OF) devices, fpga.dtbo files are used instead of fpg=
a_config
> files.
> > These .dtbo files contain all necessary information to populate the
> fpga_image_info.
> > For non-OF devices, a vendor specific fpga.config files are used to
> > provide the required data for initializing the fpga_image_info.
>=20
> non-OF fpga images usually don't contain fpga_image_info data (e.g.
> enable/disable_timeout_us). I think we don't have to force users embed th=
ese data in
> fpga image, provide additional configfs attributes to input these data is=
 possible. For
> some FPGA regions (e.g. OF), these attributes could be RO, some could be =
RW,
> depends on different FPGA region drivers.
>=20
> So I think we may have a Configuration File Upload interface, like:
>=20
>   echo "config_file" > /sys/kernel/config/fpga/<region>/image
>=20
> Some additional parameter interfaces, like:
>=20
>   echo 10000 > /sys/kernel/config/fpga/<region>/enable_timeout
>   ...
>=20
> And a Configuration interface, like:
>=20
>   # programming
>   echo 1 > /sys/kernel/config/fpga/<region>/config
>   # removing
>   echo 0 > /sys/kernel/config/fpga/<region>/config
>=20
> How do you think?
>=20

I agree and am actively working on the POC changes.
I will submit the RFC patches at the earliest.

Regards,
Navakishore.

