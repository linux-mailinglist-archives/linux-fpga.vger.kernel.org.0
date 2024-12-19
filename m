Return-Path: <linux-fpga+bounces-987-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 007C09F78CB
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Dec 2024 10:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB3D1893AEE
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Dec 2024 09:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA1E221DAE;
	Thu, 19 Dec 2024 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1tPpvDf3"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3150721D58B;
	Thu, 19 Dec 2024 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734601638; cv=fail; b=TxXTKCwH2VXtLCge8YKKKi1YMNvAOj4WQa5fb5Y1dxHMXgQ9q1lu7TJJsXGxrxm8KDKb+PU+Q37ka2xJP/gT/4UdI59Wmk1VcryB82k3VsOiDmF5kx39optHe6afo3M9y69aug6nPrlDIK5W5e636mpyunMnr6MmBaSYP6+0WaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734601638; c=relaxed/simple;
	bh=THnQ76elIJMFRVqqspSppyoAtFk3lgHIscy8wz8KV3s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mkdXII/nPLb2pRLNbWJhMmTZqp8Odi/pw0hTmmfPUw4dyFjohmh7N5XBgoqauZ3dhhmhVqeauppCuq7DVH7aZxOsoQ0qkx1b4N0xjK7VdUNKnZ/EUDuvK/Wiu+evvjekZINTVmUSAvIjjJVa5eg4fXWh3YWalq6z+7J4DZUqUwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1tPpvDf3; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epxiLk8aC0n28VzUFRuOduuEebcoz5RD42wr6AZVjBv8XOwuMPbO+vi7uuXhTAOUYKcKy0SeAR3NRge28g1WK6QGFTQmGfkWX1dpYl/nLXaAXC5iScrfqpr4I6v0BRf2zsJhMw9/p7qBn0FiGkJcmIV613eEIZnE4bjdJBCYar40lAmSq7bz2fC8qvkj+5KO8JLt7X3ff08Y1A0Gwi4h7r1hWdmviBNQJ/dYr5huY8RFiKPyhEwGROqMbRtw2SPK7ffVv5VYalJ/Bqu6X4RIfDuOv86gatkRilcyarS7WhGxm8ozXFc/FPrmZJxVHsM4LBPIEldtXso3j/12x3yX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUFJdzPUBmF8jLCCDWx8wm/M6/u+gkpdpK/Ef50gZUg=;
 b=uiZNOTU//U/BKEuT7XGSBfu9/Eyojao8D7kvJ/hAFYf5QKT26keRa3ngMAXSi7MZZujwIfRZ2r7s5fY3NwIzIxJewTCgHe+hmkCzPt7CQgSRfaw50tQt9PeFZ/A2OqMkHlhiQWvFBIR2iN/wW61A35phLxDo5iSA+YTlljkaTjZElftYETKhhQjy4lVCcvvWI2c4pui1X1FSI5IqML6nIF1uM3tExoAubMWNiGXyiNzES3wvwJ5B/ft/zIHvxfi+KAtnxyARhBmeYo/fiRNd8dYIWyzKtwTD8CLRd95fgxb45DZ++u9q9jn9ktMEgiet1dYaK0RElNsB4VjE7DDtzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUFJdzPUBmF8jLCCDWx8wm/M6/u+gkpdpK/Ef50gZUg=;
 b=1tPpvDf3NPCLLxifdpwakb9GCWFktwoPa5+p0rlkfvSTMZLvu5wAHOg6yhYZkoWW+v0rWK26yPOyioeb/heas2qdRsEeQHzwd4e5RIb4ilyATaaFUgJ/HvglfDizErKMxSqEyowziknbKd4vY9u+RvlgRtH6Pm3L/b5u5Zo91VM=
Received: from DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) by
 BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Thu, 19 Dec
 2024 09:47:12 +0000
Received: from DS7PR12MB6070.namprd12.prod.outlook.com
 ([fe80::b847:e013:8f93:f6e4]) by DS7PR12MB6070.namprd12.prod.outlook.com
 ([fe80::b847:e013:8f93:f6e4%6]) with mapi id 15.20.8272.013; Thu, 19 Dec 2024
 09:47:12 +0000
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
 AQHbKeN81itnx65szk2mzvzQ12GeBbK+H1CAgAN+t4CACOtuAIALTWAAgAmaNICADi35oA==
Date: Thu, 19 Dec 2024 09:47:12 +0000
Message-ID:
 <DS7PR12MB60706A47591D7F3CC6D41398CD062@DS7PR12MB6070.namprd12.prod.outlook.com>
References: <20241029091734.3288005-1-nava.kishore.manne@amd.com>
 <20241029091734.3288005-2-nava.kishore.manne@amd.com>
 <ZzwQrYeWVF6cRtgA@yilunxu-OptiPlex-7050>
 <DS7PR12MB6070AAA0C413DBF26F685207CD222@DS7PR12MB6070.namprd12.prod.outlook.com>
 <Z0Z6socXrmHQ26C0@yilunxu-OptiPlex-7050>
 <DS7PR12MB6070F3DD9119CD7955EF8AFCCD372@DS7PR12MB6070.namprd12.prod.outlook.com>
 <Z1gD7QvhSN8p6//v@yilunxu-OptiPlex-7050>
In-Reply-To: <Z1gD7QvhSN8p6//v@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6070:EE_|BY5PR12MB4146:EE_
x-ms-office365-filtering-correlation-id: 82fb2e0c-dd77-4462-d4b4-08dd20121ce3
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7H4MCvyeuA0o0YtXAsOKAFcsXKpPnAJ6GA79nKPKXmYDK5/fwOTv++6YYDjz?=
 =?us-ascii?Q?vf+EbVFTBoR2V86tppp7PdgtysePQA/wozv4Mk7VncCNqh5IVS6OWFPDnvP/?=
 =?us-ascii?Q?vWgOzW52yNajKP+x9uSxW5fSRAc0x/gl91kacRIq+KUX0lZjFDF0xr0jErww?=
 =?us-ascii?Q?cfpCwo53BNT/NLpvT0Cpmw8DypdJ7Uhqf5k/cfn5BBrnLJ84VRtOS4WBsjAo?=
 =?us-ascii?Q?0TwLVDxBttqeIvFSYPXiVXYv3TotiW/zYFHWPiqzTORmyXqr5QOsCXEefhqb?=
 =?us-ascii?Q?CsGg2Jece/VmZAQ280IxKY6gb5ms375eMh2pQjEsKHGAxZJ+vJXjmbB2m5GT?=
 =?us-ascii?Q?cQAcwULIOBuWv9Qv+WsU6H7nHDhNxtMZRibu756+rNwXb6t5sTo2tdvBUC9S?=
 =?us-ascii?Q?Bbg2tHKipNnrF4EIjI0JC7yKgHyhDkOu/llXWIeAj0mDcpTukTF+eHBSlSdh?=
 =?us-ascii?Q?iC5TYRBSqfLRD5OU+jKl4pCx0/WLJJaMgLIxSkYCTiWJhSRx6tKv46P1eg7X?=
 =?us-ascii?Q?Hu8CDh47mcGlkyT+I3s8pUxP7jEK0egNiRxACI6GmrcLLNwOj/VXyBz+TpaC?=
 =?us-ascii?Q?/4E62QDy8Ng7MxKjfV1fh3ZZtzzP3PojxETVxPdC+2+TcvuS5VU79sTGKq/u?=
 =?us-ascii?Q?0YJ5RH1hy27tGSTUc8hYOG0pz8UbThc4bn9qCVi0Vd6bq969CaxPjBWVCNRs?=
 =?us-ascii?Q?8ekQurOPfl3SlY48pvcISKnBgAzA9cVmF9iDV+WrjyZH6Vzf/IGt4yv6bM5Q?=
 =?us-ascii?Q?/q3R5U2iEhkZ7nL8BS8u45DswwH6cZMQmOrFyfa6pMwamxqpaoQ2vlnpIium?=
 =?us-ascii?Q?WB29O00p9TtBH9LWSVOSE2pKR4SxObvBRYGqxsLUjGYOweVTMQkgvFoJZBlv?=
 =?us-ascii?Q?mm9b5K3pbG8JpmzI7VDJb3xNGImJ5wjqUkcLAEuvMxdlBvTTWFTXO44Qz/oD?=
 =?us-ascii?Q?kklvaoEGPxGNC4kSTCux+y/aD83jgVLooBkVgaKRq/hTvQMWNXX9Ux/NgvKV?=
 =?us-ascii?Q?WXjABBkhphdS9mqnzja2F5LG5Vffjlh/n8zqSzcAvrpFWfZ8KZHOVu3tTN9D?=
 =?us-ascii?Q?ouQZYgu6BtpX9r54aNlDe2cf58TH1PTX8ZX632MjluEBLVE/q23AKiNfVqEO?=
 =?us-ascii?Q?R9p2BtRrq5EpBZTOAI+bmCJAXPtmEWz+Mr/T2tNeWZhIj/CjEpDLlDQAR7t4?=
 =?us-ascii?Q?3xXcQcFMzuaL5XapqjhI0VcO2pirhdwObQiQlyzHuUyAyq+F9QhY0oCFVD3N?=
 =?us-ascii?Q?HqBh3QHhdvsdfKKF9QEFacgrJ5cwiezSQ4+hJFaPSwNa9/fFX8WyBoMLYOmp?=
 =?us-ascii?Q?w0hh23hVw3lQEfflTujyvfXcbK+w7i16tFp03A7s65+9G50Uuyw7WDp8TDLn?=
 =?us-ascii?Q?GcFI5i+1JtHJsB74sKfoacmGs5kt/dO6v02M87XpBYT8+U4+aTe3NC2fV/yD?=
 =?us-ascii?Q?wvtMW6GwWcmDkU7gQpMJseX86neHWG6W?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?08R1kffZfmu2u1dpEnXijRP1XwDhipE4y2aqgULON/FS1SjVFTuAsVwfPhl3?=
 =?us-ascii?Q?9rOojKeJFGih5r7GpxTvlLblIE1EiDAWQWf48aRfWjXna25Fq3GKY7ksZOLt?=
 =?us-ascii?Q?hqpCMBkBCKn8bS+ekefgERDUVS+4/wZIKPvDXyULWdEVG9nvCwslATg5G4lQ?=
 =?us-ascii?Q?5GnqjNDQ/+5nlrM4a5VDCyWrWug95t4HWSJZXWnkNUOhWCKu6o2IurodEmt1?=
 =?us-ascii?Q?EI9nkU97t35asj1iObdsSU5j6OHPm5Xk8HHwX9Xkq63/Is5szPKDIlhSLJ/E?=
 =?us-ascii?Q?1avTwfcHuEYbngWrwI0Se3lRHjsxHFUq0RUqJ8uf29f72tPNDVLA14MK6qO5?=
 =?us-ascii?Q?3mDoAz4cTq3hQTTEfOzi5rQZSRq7GQ/Vhh4NI3cLGhGODggn6xRgkMjNED5b?=
 =?us-ascii?Q?moRKvDVr4nVeXRSR2IOiGPsx1wbWDEcJw69ZIvp9sBMdXyyNVCQYyFASjAAU?=
 =?us-ascii?Q?YlSIC+cBr776P8juw96rupdAhRpey7Xw7xZ8v7b0B4XPK334zrjh8Q/EU3/D?=
 =?us-ascii?Q?p1g4Cbw5Os0jE3VpeP4GpHL17bpwy5ldmFlkgc3eWzGfSWe52C5wzDYir78j?=
 =?us-ascii?Q?RMilbPaQBcS7jkbLdqDgxJcjTlIASL0n8dn7KMR3/jFUiy1n9WgM70ySdW52?=
 =?us-ascii?Q?11X4U5L/qoLmM50I2YGLo8ekCuojhzDxHpuFWiFJdz51+NRv9kXNxMn3eOJH?=
 =?us-ascii?Q?tD3eXUdVJwMBpELJV2bSdkdkNq01FIpdVa3ULXtubN57gWI6rgz1tenhYEUP?=
 =?us-ascii?Q?6en+or+J9SXg1WsTVnhjqQ8UGCbdXoUBEDfEq0o+zR/Q1GQWwavefxVCLMrA?=
 =?us-ascii?Q?jLukhBuIZAy5969YRSuNIbypsl7+4GpE6JHMi/jSHT/SLWpUAZzJeqDoYyF5?=
 =?us-ascii?Q?ExwvWj2/OjbpNrU25Np1ggOFn7f/ZWEw/dyjORIbEDVSiSsRyRzv0FNO0Iji?=
 =?us-ascii?Q?EvvXJ6yylBXiagwGhvfdY4Y/28CXy2WvJeHmTNzYjNxLF3uTP9DpYckRbIoT?=
 =?us-ascii?Q?bbkI/ya5JvqGi2wfplQ+QXwKle/DTrgzJQnibgTT876wyD3KZPeHdOO/4LbT?=
 =?us-ascii?Q?/eKwJALtuYR/SmN+UYo+q6n9EHPv84Ud/zTQuWlXrcSjSGxoPWs2Yt7vrcn3?=
 =?us-ascii?Q?it9uNEeP1L759qCptQsV83BGQlsx49o8B3n4hEibvS9Js7JgDHc5a/Z/5tuz?=
 =?us-ascii?Q?cxKg5kbgVC0g2VCLY2lnILxkzzjm6f02+GUestHZBEAWNvMTUtqYJxSDc7sG?=
 =?us-ascii?Q?vDYoBcJNLAI1CKGojsd7DnQI84SioRomD69ISVMXOxD3THOfIs7t+bWDNfJ3?=
 =?us-ascii?Q?HD6qEiHmg82I2qiIiRTpwclaeELdFX6lDTcSYnVhr0XXbPihKnLu8KHjeOki?=
 =?us-ascii?Q?5v7HU29vKVSpTMbnZJUx/LGMfoGIzftnBtjkPwodf4GmShT6UmyRz9rVVYNb?=
 =?us-ascii?Q?48YkgX7QXmyWhvyyHc3K9zYg1A2HmVexUiXz3aqp12GSZvgZ6A4XTdKhRbxK?=
 =?us-ascii?Q?dCkOtQVrpQEtXJnWwa/xmdvQOf4zVnpSznLjtjYOiHQ7g9SonkHs2Y/J62wU?=
 =?us-ascii?Q?9aEcB+G8grC91fBRrEM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fb2e0c-dd77-4462-d4b4-08dd20121ce3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 09:47:12.2369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cBPWEdxH6UseA8GqTV0UPcZnBjzDmd6AmPmQlewkLRxEN5y3VHQP29iJh0A644xP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146

Hi Yilun,

> -----Original Message-----
> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Tuesday, December 10, 2024 2:34 PM
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
> On Wed, Dec 04, 2024 at 06:40:18AM +0000, Manne, Nava kishore wrote:
> > Hi Yilun,
> >
> > > -----Original Message-----
> > > From: Xu Yilun <yilun.xu@linux.intel.com>
> > > Sent: Wednesday, November 27, 2024 7:20 AM
> > > To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> > > Cc: git (AMD-Xilinx) <git@amd.com>; mdf@kernel.org;
> > > hao.wu@intel.com; yilun.xu@intel.com; trix@redhat.com;
> > > robh@kernel.org; saravanak@google.com; linux-kernel@vger.kernel.org;
> > > linux-fpga@vger.kernel.org; devicetree@vger.kernel.org
> > > Subject: Re: [RFC v2 1/1] fpga-region: Add generic IOCTL interface
> > > for runtime FPGA programming
> > >
> > > > > > + * struct fpga_region_ops - ops for low level FPGA region ops
> > > > > > +for device
> > > > > > + * enumeration/removal
> > > > > > + * @region_status: returns the FPGA region status
> > > > > > + * @region_config_enumeration: Configure and enumerate the FPG=
A
> region.
> > > > > > + * @region_remove: Remove all devices within the FPGA region
> > > > > > + * (which are added as part of the enumeration).
> > > > > > + */
> > > > > > +struct fpga_region_ops {
> > > > > > +	int (*region_status)(struct fpga_region *region);
> > > > > > +	int (*region_config_enumeration)(struct fpga_region *region,
> > > > > > +					 struct fpga_region_config_info
> *config_info);
> > > > >
> > > > > My current concern is still about this combined API, it just
> > > > > offloads all work to low level, but we have some common flows.
> > > > > That's why we introduce a common FPGA reprograming API.
> > > > >
> > > > > I didn't see issue about the vendor specific pre configuration.
> > > > > They are generally needed to initialize the struct
> > > > > fpga_image_info, which is a common structure for
> fpga_region_program_fpga().
> > > > >
> > > > > For port IDs(AFU) inputs for DFL, I think it could also be
> > > > > changed (Don't have to be implemented in this patchset).
> > > > > Previously DFL provides an uAPI for the whole device, so it
> > > > > needs a port_id input to position which fpga_region within the
> > > > > device for programming. But now, we are introducing a per
> > > > > fpga_region programming interface, IIUC port_id
> > > should not be needed anymore.
> > > > >
> > > > > The combined API is truly simple for leveraging the existing
> > > > > of-fpga-region overlay apply mechanism. But IMHO that flow
> > > > > doesn't fit our new uAPI well. That flow is to adapt the generic
> > > > > configfs overlay interface, which comes to a dead end as you ment=
ioned.
> > > > >
> > > > > My gut feeling for the generic programing flow should be:
> > > > >
> > > > >  1. Program the image to HW.
> > > > >  2. Enumerate the programmed image (apply the DT overlay)
> > > > >
> > > > > Why we have to:
> > > > >
> > > > >  1. Start enumeration.
> > > > >  2. On pre enumeration, programe the image.
> > > > >  3. Real enumeration.
> > > > >
> > > >
> > > > I agree with the approach of leveraging vendor-specific callbacks
> > > > to handle the distinct phases of the FPGA programming process.
> > > > Here's the proposed flow.
> > > >
> > > > Pre-Configuration:
> > > > A vendor-specific callback extracts the required pre-configuration
> > > > details and initializes struct fpga_image_info. This ensures that
> > > > all vendor-specific
> > >
> > > Since we need to construct the fpga_image_info, initialize multiple
> > > field as needed, I'm wondering if configfs could be a solution for th=
e uAPI?
> > >
> >
> > A configfs uAPI isn't necessary, we can manage this using the proposed =
IOCTL
> flow.
> > The POC code looks as follows.
>=20
> I prefer more to configfs cause it provides standard FS way to create the
> fpga_image_info object, e.g. which attributes are visible for OF/non-OF r=
egion, which
> attributes come from image blob and can only be RO, etc.
>=20
> Of couse ioctl() could achieve the same goal but would add much more spec=
ific rules
> (maybe flags/types) for user to follow.
>=20

Agreed. Using ConfigFS is preferable because it provides a standardized fil=
esystem
interface for creating and managing the fpga_image_info object.

The proposed new user interface is outlined as follows:

# Mount ConfigFS filesystem
mount -t configfs none /sys/kernel/config

# Upload Configuration and Load the Bitstream for the Targeted FPGA Region.

Configuration File Upload:
Upload the configuration file containing the necessary metadata or settings=
 required
for configuring the FPGA region. This file may vary based on the vendor and=
 includes
important details specific to the vendor's requirements.

Vendor-Specific Callback:=20
A vendor-specific callback function extracts the relevant configuration dat=
a from the file.
The format and contents of the configuration file can differ between vendor=
s. The callback
then initializes the struct fpga_image_info, ensuring all vendor-specific r=
equirements are
satisfied.

Device-Specific Considerations:
For Open Firmware (OF) devices, fpga.dtbo files are used instead of fpga_co=
nfig files.
These .dtbo files contain all necessary information to populate the fpga_im=
age_info.
For non-OF devices, a vendor specific fpga.config files are used to provide=
 the required
data for initializing the fpga_image_info.

FPGA Configuration:
Once the configuration details are extracted and the fpga_image_info struct=
ure is initialized,
the FPGA can be programmed accordingly.

echo "config_file" > /sys/kernel/config/fpga/<region>/config


# Check the status of "region"
cat /sys/kernel/config/fpga/<region>/status

# Remove "region"
echo "remove" > /sys/kernel/config/fpga/<region>/remove

Looking forward to your feedback.

Regards,
Navakishore.


