Return-Path: <linux-fpga+bounces-970-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 334AD9D4A72
	for <lists+linux-fpga@lfdr.de>; Thu, 21 Nov 2024 11:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75A46B217DC
	for <lists+linux-fpga@lfdr.de>; Thu, 21 Nov 2024 10:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1981CBA1B;
	Thu, 21 Nov 2024 10:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rGTx4Jqj"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97275FEED;
	Thu, 21 Nov 2024 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732183628; cv=fail; b=p33Enqki2QlvvZecRlPM/iAJG7qDF2ZCCEzlffNoQpGLqQGBzjC10H12vQt7Qznhs96Bai1zLdhvRuLpXc9S/05259IjKr0akkKem3MQPQpFnsxCAoJkh/bVUz+jm7YSDIHdolpRc0IDxsq5w1/ZmOz78wSAh1CISosFIXlpulQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732183628; c=relaxed/simple;
	bh=V+sCQNb49cIRRnM/c/fYJPQVHsY4Fr9BU0m2gq/hOUg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PLPfpRuZ0OSEPyacY38wRblNX4/bvy8qnRaEIJrufQRj6k4A2EW/OnhYQ3NFbRtR7qavOvgE7cuy37dCTtTJbYX6NlUMh+22CK1wKxmaK1jy245fYMBeNodEnBERk3Jd6xBjhpHmugaJ5P9aTyE4eNlB9KiKuG0v/NrlcbKQAXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rGTx4Jqj; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQkaPVxhlZ4NyeZDAed4kAfKcZCx6PQtKZqapIqF/7cs2iMwhWbNNbiXrPgv3hJNhO26CUn99png05TbVi+g3I+XRVPbWQ0ym38MZA2S/BU5d92s9XMlQ4O6k+GbB9uHEQ0NzVN24B6rHpCFC7HCXIkkoMC8utztKnO4w1jlP3Xmqgz5SMXO3JTCYsIsBnhXmXiCyxKVOpaUPXUXkteAWmwVfaWBnNS2OKXFHJIowUwOzjn6hdv3nEzkG30Y9gR01j+d4Qojq9W7BoqCOwUy85o4jsFTw7jy9a7AQL7OTOP9MpUPkC2z/IZ9SNLKeQnR3Sfyv39k6/kmTUxev+5kDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpJAItPFK8gDGHFJtLSi4XHQHzRFQnQ5tsTJS7InVDw=;
 b=AFU3TDWrvCAkpCDJBXH3a1SVjc2lbsUcYnRkCz8SRcV5NJf8FBtyeVGToGtFKbkohHTtOAkGmuH9bGvNOSnrLlpNRvjRROYeiq8s5weDdZe7noOSPyAA1grH+TXa3ZpwF0474EeQpcHaXR7nRzTGzY2L+pT6gG4+VqnV/RiRFaG82bIFIgFCGSaWD3rqQrIYWgFuzGyySnLPzevV9MTAkJwoes8iKAvVJ8w2ECU/ryOcKNe1IECl5wdbfVWQBZiAPuFaBqY+zMHca35LKI3SNT5s+lTnX/FcDArtG5zKSvo6aKM/Jys38dKL6BDay9M8vs3O1EHNaKBcnnKP5oP33Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpJAItPFK8gDGHFJtLSi4XHQHzRFQnQ5tsTJS7InVDw=;
 b=rGTx4Jqj83wbEQ2oWNkEMiqk/6tTJ9hAOXphjgHzAuj7sR0Ptb73jwwOgp0lIwFh2IfbiP4t0PUpQ4uSP2RLwpmVY792PeJoKV3CzhGGhBntOV3wrTT437d2mbZPdr7jlLfb6QmvxuEkLMTGH24QiHlP20BiiVlnO/ng5Q4Lmmo=
Received: from DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) by
 IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.23; Thu, 21 Nov 2024 10:07:00 +0000
Received: from DS7PR12MB6070.namprd12.prod.outlook.com
 ([fe80::b847:e013:8f93:f6e4]) by DS7PR12MB6070.namprd12.prod.outlook.com
 ([fe80::b847:e013:8f93:f6e4%5]) with mapi id 15.20.8182.014; Thu, 21 Nov 2024
 10:07:00 +0000
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
Thread-Index: AQHbKeN81itnx65szk2mzvzQ12GeBbK+H1CAgAN+t4A=
Date: Thu, 21 Nov 2024 10:07:00 +0000
Message-ID:
 <DS7PR12MB6070AAA0C413DBF26F685207CD222@DS7PR12MB6070.namprd12.prod.outlook.com>
References: <20241029091734.3288005-1-nava.kishore.manne@amd.com>
 <20241029091734.3288005-2-nava.kishore.manne@amd.com>
 <ZzwQrYeWVF6cRtgA@yilunxu-OptiPlex-7050>
In-Reply-To: <ZzwQrYeWVF6cRtgA@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6070:EE_|IA1PR12MB7735:EE_
x-ms-office365-filtering-correlation-id: 5e187248-423b-4819-0a21-08dd0a143d5a
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UTvm5La1bvsn4PPOKZjONMQiN0O5bGC0FYJTG3xTzM17Jdi7TyVd30ZAGIiY?=
 =?us-ascii?Q?GQj1S4vcBorDDRYfYVQl4Nbu83mbm3yA7YPLD+hxrQBTj43rnEXd8w8ZFvBs?=
 =?us-ascii?Q?u/qYaojZ6xI9SMizV2yHR8EYffCxgKRbYOM5egTRfcgBKLLCQA+OPaenPzCn?=
 =?us-ascii?Q?N5lh1RLpgqB0tUy/r8jblFtbIVpOPF96vI2Qu0U7eB4c/WdfxIGVdFuG/Aj8?=
 =?us-ascii?Q?Qm6+kf1m/AoJS3tHmBQYky4ZE+nuaPe8ksiVi5dWVZxy5QWU/uM6705kh6Hw?=
 =?us-ascii?Q?on5r7FLGRfVAC5xseOs2FqigZHgNT3ViwZq+SURIwffIRCYQHrmOrus2Xc4D?=
 =?us-ascii?Q?CV+jIFRW9Py3guvykKm0aEZQDMm411USwZFPDqllJv/kRFWLV0TGDrJmINqQ?=
 =?us-ascii?Q?0XamBIH0F5J0BBipznzim1gp4B/r+Ps/g9eWdG90dNGVy0vJbmlzRMnhfEIi?=
 =?us-ascii?Q?T+1pu4Q3I67dR2C+6S8p4e+EcgP/sakmQNDQZhns0Bw+6TQCI8N2aOi6X70K?=
 =?us-ascii?Q?PJJyEmaajrkLd4TDypswxQAqNZ2yvKv2QZnyMsJfYULHx7FCLumG38859sjq?=
 =?us-ascii?Q?MSUpcb5XKM0QEej/pMt0qjdibZkHhp3PZLqvm4ZUQO2QYAZvvCoitxyTzEbS?=
 =?us-ascii?Q?HzOTqWOL7xihglF/NjQ2MGDXMQ4puNym0vbPzN5nN+5exQ5Pd2TyshJ5wS/o?=
 =?us-ascii?Q?kbByQAekt3VVh4xhsHUUoHIyYrAoBXTjZtiuz6kodwdqm4AYW8Z8MrzkkuTp?=
 =?us-ascii?Q?MLHBgxTZb5+bOSY8XyXmWMV5+S1auRpumeEgIC6gBGH6FxgEqVyrJEJ42Vw5?=
 =?us-ascii?Q?v+Iewt7sfxUVOEwReWf1JGn4uhQBAdISISbQupi0oY7SngBOzmBHGGmsHriG?=
 =?us-ascii?Q?ugt+64QcBtQ71p23xzGVKfgWVIaEgP7w01Otabo6ixHOnNQAYvvqD3i0NPkY?=
 =?us-ascii?Q?b395gXII9IgOEmFwMrwfGqiewADrQqZXYMhz9XN/1yGbsk+IYh1UhrcmWs4l?=
 =?us-ascii?Q?Xv4eVMyQ/ccda2HFmJEuShTA/C5YECYEPg5+mr1ZmMsgA4eI10dKOtqKn/Wf?=
 =?us-ascii?Q?gzFnXD5DSBU07VVv3XEJN/q0CgQBrO436TSUiLXIShIWXsSTjy9t3cmktRYA?=
 =?us-ascii?Q?8D7FQHd7qU7r/uFMBsoDsdqCQ5J+1qyar0/WTlJmxOuWcPx1unqo3JVrOyPc?=
 =?us-ascii?Q?JrmC5hj2cZa0IYdywIgg9JcxSNn1P/ojD7zNu0HET8eLg15bYzTVYFUFQcVT?=
 =?us-ascii?Q?5RK65zPUeSoS3bq067wqDKwjJ/6589X02WClSBOd88Hyiamo3TrMc3NKkWJ7?=
 =?us-ascii?Q?uaPu+sJlibGgl2/Iizk78CvqW4vsU1vy9uRIhviYIjAI9WYiBXKx0n5MYDFL?=
 =?us-ascii?Q?fB3u+B8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LPnTLeSxWf2ASmasxVH1WFoGLp/zoDRigS/NFZVlBLDBTdVYTOITj9MCGfcA?=
 =?us-ascii?Q?rNH2DIvrPiRAiDqpxtzGqG7/0gylMwYTJXAHzuOAYpwSJxeKF6YhGARGX+1e?=
 =?us-ascii?Q?df3Ka0AXaAW63TLti43CRAIEAg9C7KSzJG99pCNiLTnlM1XE4J3N8nOo2LZx?=
 =?us-ascii?Q?bXomOQ9hBPMz7PnHYqQ98OgWnutQBCVMcSepC5HtrJcfQZerzO9b9iSR503n?=
 =?us-ascii?Q?KW+lRmZHRPGTfA0/d68mjm5J3Df+ubmz4gO0zUJV/W/ZIIqhdYvjxvriIble?=
 =?us-ascii?Q?mBt/ytQwGq7ta5ptvrJRrwuY0SDApH4PuyCnrCqbXKpvBpIUqx3We7YDCW/L?=
 =?us-ascii?Q?1vbZwgNc0B0zZgIisFoEKbLER2L6TvG1EWdLgU1lU8yrNjj6qYDSLFDKPQSs?=
 =?us-ascii?Q?+boGJakPckwhrEKKVNBXxldF0j0NmqJOkiQoI93jwEjFzG3bypklMRcwF54b?=
 =?us-ascii?Q?6Jl6HSsRLepEivm0u9II4NZRZk6wfNNQxgesLOBB/m3jfrhT5FtdDCzG+86t?=
 =?us-ascii?Q?jEBBo9BqqXi9AEq0orjnX4sgMSL3u5B3/ZBYqYBVFDy7+MgeV1p/UImwdh40?=
 =?us-ascii?Q?ZK/La+xr9sgUsP0QmMONOfMRmW6jZzAkeVjZTlZFOyUHJRqCp9hfRk9y2dPQ?=
 =?us-ascii?Q?VcrIg3LoWwlJkOSZVOYy3nqGm92ZUKfMDvBjcN7Ul4SUqE2N7x2OGfprDSvh?=
 =?us-ascii?Q?Y5/u876HomaeXyKxc2v2dkHh0Q80u6/FCHRtAzxVXmlGtQSFPMCR0OHOjvXA?=
 =?us-ascii?Q?bHhtd49l5GXDFVrBVI5ENlfI9n4sla0DV1Y525Acs4wTX1iKg29EluWLgVQi?=
 =?us-ascii?Q?Bznc9xjLvokTdDhdYpYyou7S8iUyWefd9gIuljR3lR96vaJlgf1GcJcEL2o3?=
 =?us-ascii?Q?dkc8DUPRVdLwSJDGc/OQKNq4WI1/nUpPJw7o4jalis6g1o4dIltfVVl/RwW4?=
 =?us-ascii?Q?su4GxwWHJSrrR2Vt4KO43l+79F8b7HPkoH4p2ggIitGyRa03SH0NBrg2Fn2n?=
 =?us-ascii?Q?TiAMsSZV90H66fvaNUtM/kkq37pfg9NoYtB9twc9ZGwUwIO4/MtBiUwmqG8F?=
 =?us-ascii?Q?ZLWhmBtgHVq4yojdJI5G9WgAsCFK6nhcRKBbz+YTnncox5QCXYYVq234uELh?=
 =?us-ascii?Q?lkXrItk7nMKJrtVavOCcW7CLyCo+YkH5aUnyV8+rM89dm5LJjT+K9PqIzoi3?=
 =?us-ascii?Q?Ynmlny1liyvkJSnbQyO/CZC0Uu+pVnM8bcUns0RW7H2afrqKXWzFMzyiFXcc?=
 =?us-ascii?Q?suKcg0JMlSFLP1NwhJNMdmZ9QRTAjv/vMeCRvnzfaW5I7DPul1zh4Y4adsKe?=
 =?us-ascii?Q?hojLxqr/alDN6FtuwE300Ljnjfuld7jGNNaRZNqtMAt2bRICE55R2TyyvEIC?=
 =?us-ascii?Q?d3HAyvt/MrOuM3F1sER8MOprH8EGuwtJImQ16yjlSWOWS2q/N1tcbADFIrX2?=
 =?us-ascii?Q?G7a9l5QvwZ1E4cqOVEabuJrAjyVhzqFMsgLfRT2KyLdVspATN0Udg9kMhIuD?=
 =?us-ascii?Q?CI/06webTPu6b0hsMbOJpU0FeF0zt3wf44FO0VVImyRM15RmDSiwl3QaBUvn?=
 =?us-ascii?Q?9vrqvt4lCCauCRTkREs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e187248-423b-4819-0a21-08dd0a143d5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 10:07:00.1219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eGp1v2nGiSiXWexEVad7DWBVudPMdYNar4WKXdRGqk9aVbJ+8ne0yL7yC7Oug/14
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735

Hi Yilun,

> -----Original Message-----
> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Tuesday, November 19, 2024 9:45 AM
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
> On Tue, Oct 29, 2024 at 02:47:34PM +0530, Nava kishore Manne wrote:
> > Introduces an IOCTL interface within the fpga-region subsystem,
> > providing a generic and standardized mechanism for configuring (or)
> > reprogramming FPGAs during runtime. The newly added interface supports
> > both OF (Open Firmware) and non-OF devices, leveraging vendor-specific
> > callbacks (e.g., configuration + enumeration, removal, and status) to
> > accommodate a wide range of device specific configurations.
> >
> > The IOCTL interface ensures compatibility with both OF and non-OF
> > devices, allowing for seamless FPGA reprogramming across diverse
> > platforms.
> >
> > Vendor-specific callbacks are integrated into the interface, enabling
> > custom FPGA configuration + enumeration, removal, and status reporting
> > mechanisms, ensuring flexibility for vendor implementations.
> >
> > This solution enhances FPGA runtime management, supporting various
> > device types and vendors, while ensuring compatibility with the
> > current FPGA configuration flow.
> >
> > Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> > ---
> > Changes for v2:
> >  - As discussed with Yilun, the implementation has been modified to
> > utilize a  callback approach, enabling seamless handling of both OF and=
 non-OF
> devices.
> >
> >  - As suggested by Yilun in the POC code, we have moved away from
> > using  void *args  as a parameter for ICOTL inputs to obtain the
> > required user inputs. Instead, we are  utilizing the
> > fpga_region_config_info structure to gather user inputs. Currently,
> > this structure is implemented to support only OF devices, but we intend=
 to extend
> it by incorporating new members to accommodate non-OF devices in the futu=
re.
> >
> >  drivers/fpga/fpga-region.c       | 110 +++++++++++++++++++++++++++++++
> >  drivers/fpga/of-fpga-region.c    |  91 ++++++++++++++++++++++++-
> >  include/linux/fpga/fpga-region.h |  32 +++++++++
> > include/uapi/linux/fpga-region.h |  51 ++++++++++++++
> >  4 files changed, 283 insertions(+), 1 deletion(-)  create mode 100644
> > include/uapi/linux/fpga-region.h
> >
> > diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> > index 753cd142503e..c6bea3c99a69 100644
> > --- a/drivers/fpga/fpga-region.c
> > +++ b/drivers/fpga/fpga-region.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/fpga/fpga-bridge.h>
> >  #include <linux/fpga/fpga-mgr.h>
> >  #include <linux/fpga/fpga-region.h>
> > +#include <linux/fpga-region.h>
> >  #include <linux/idr.h>
> >  #include <linux/kernel.h>
> >  #include <linux/list.h>
> > @@ -180,6 +181,67 @@ static struct attribute *fpga_region_attrs[] =3D {
> > };  ATTRIBUTE_GROUPS(fpga_region);
> >
> > +static int fpga_region_device_open(struct inode *inode, struct file
> > +*file) {
> > +	struct miscdevice *miscdev =3D file->private_data;
> > +	struct fpga_region *region =3D container_of(miscdev, struct
> > +fpga_region, miscdev);
> > +
> > +	file->private_data =3D region;
> > +
> > +	return 0;
> > +}
> > +
> > +static int fpga_region_device_release(struct inode *inode, struct
> > +file *file) {
> > +	return 0;
> > +}
> > +
> > +static long fpga_region_device_ioctl(struct file *file, unsigned int c=
md,
> > +				     unsigned long arg)
> > +{
> > +	int err;
> > +	void __user *argp =3D (void __user *)arg;
> > +	struct fpga_region_config_info config_info;
> > +	struct fpga_region *region =3D  (struct fpga_region
> > +*)(file->private_data);
> > +
> > +	switch (cmd) {
> > +	case FPGA_REGION_IOCTL_LOAD:
> > +		if (copy_from_user(&config_info, argp, sizeof(struct
> fpga_region_config_info)))
> > +			return -EFAULT;
> > +
> > +		err =3D region->region_ops->region_config_enumeration(region,
> > +&config_info);
> > +
> > +		break;
> > +	case FPGA_REGION_IOCTL_REMOVE:
> > +		if (copy_from_user(&config_info, argp, sizeof(struct
> fpga_region_config_info)))
> > +			return -EFAULT;
> > +
> > +		err =3D region->region_ops->region_remove(region, &config_info);
> > +
> > +		break;
> > +	case FPGA_REGION_IOCTL_STATUS:
> > +		unsigned int status;
> > +
> > +		status =3D region->region_ops->region_status(region);
> > +
> > +		if (copy_to_user((void __user *)arg, &status, sizeof(status)))
> > +			err =3D -EFAULT;
> > +		break;
> > +	default:
> > +		err =3D -ENOTTY;
> > +	}
> > +
> > +	return err;
> > +}
> > +
> > +static const struct file_operations fpga_region_fops =3D {
> > +	.owner		=3D THIS_MODULE,
> > +	.open		=3D fpga_region_device_open,
> > +	.release	=3D fpga_region_device_release,
> > +	.unlocked_ioctl	=3D fpga_region_device_ioctl,
> > +	.compat_ioctl	=3D fpga_region_device_ioctl,
> > +};
> > +
> >  /**
> >   * __fpga_region_register_full - create and register an FPGA Region de=
vice
> >   * @parent: device parent
> > @@ -229,8 +291,21 @@ __fpga_region_register_full(struct device *parent,=
 const
> struct fpga_region_info
> >  	if (ret)
> >  		goto err_remove;
> >
> > +	if (info->region_ops) {
> > +		region->region_ops =3D info->region_ops;
> > +		region->miscdev.minor =3D MISC_DYNAMIC_MINOR;
> > +		region->miscdev.name =3D kobject_name(&region->dev.kobj);
> > +		region->miscdev.fops =3D &fpga_region_fops;
> > +		ret =3D misc_register(&region->miscdev);
> > +		if (ret) {
> > +			pr_err("fpga-region: failed to register misc device.\n");
> > +			goto err_remove;
> > +		}
> > +	}
> > +
> >  	ret =3D device_register(&region->dev);
> >  	if (ret) {
> > +		misc_deregister(&region->miscdev);
> >  		put_device(&region->dev);
> >  		return ERR_PTR(ret);
> >  	}
> > @@ -272,6 +347,40 @@ __fpga_region_register(struct device *parent,
> > struct fpga_manager *mgr,  }
> > EXPORT_SYMBOL_GPL(__fpga_region_register);
> >
> > +/**
> > + * __fpga_region_register_with_ops - create and register an FPGA
> > +Region device
> > + * with user interface call-backs.
> > + * @parent: device parent
> > + * @mgr: manager that programs this region
> > + * @region_ops: ops for low level FPGA region for device
> > +enumeration/removal
> > + * @priv: of-fpga-region private data
> > + * @get_bridges: optional function to get bridges to a list
> > + * @owner: module containing the get_bridges function
> > + *
> > + * This simple version of the register function should be sufficient f=
or most users.
> > + * The fpga_region_register_full() function is available for users
> > +that need to
> > + * pass additional, optional parameters.
> > + *
> > + * Return: struct fpga_region or ERR_PTR()  */ struct fpga_region *
> > +__fpga_region_register_with_ops(struct device *parent, struct fpga_man=
ager
> *mgr,
> > +				const struct fpga_region_ops *region_ops,
> > +				void *priv,
> > +				int (*get_bridges)(struct fpga_region *),
> > +				struct module *owner)
> > +{
> > +	struct fpga_region_info info =3D { 0 };
> > +
> > +	info.mgr =3D mgr;
> > +	info.priv =3D priv;
> > +	info.get_bridges =3D get_bridges;
> > +	info.region_ops =3D region_ops;
> > +
> > +	return __fpga_region_register_full(parent, &info, owner); }
> > +EXPORT_SYMBOL_GPL(__fpga_region_register_with_ops);
> > +
> >  /**
> >   * fpga_region_unregister - unregister an FPGA region
> >   * @region: FPGA region
> > @@ -280,6 +389,7 @@ EXPORT_SYMBOL_GPL(__fpga_region_register);
> >   */
> >  void fpga_region_unregister(struct fpga_region *region)  {
> > +	misc_deregister(&region->miscdev);
> >  	device_unregister(&region->dev);
> >  }
> >  EXPORT_SYMBOL_GPL(fpga_region_unregister);
> > diff --git a/drivers/fpga/of-fpga-region.c
> > b/drivers/fpga/of-fpga-region.c index 8526a5a86f0c..63fe56e0466f
> > 100644
> > --- a/drivers/fpga/of-fpga-region.c
> > +++ b/drivers/fpga/of-fpga-region.c
> > @@ -8,6 +8,8 @@
> >  #include <linux/fpga/fpga-bridge.h>
> >  #include <linux/fpga/fpga-mgr.h>
> >  #include <linux/fpga/fpga-region.h>
> > +#include <linux/firmware.h>
> > +#include <linux/fpga-region.h>
> >  #include <linux/idr.h>
> >  #include <linux/kernel.h>
> >  #include <linux/list.h>
> > @@ -18,6 +20,20 @@
> >  #include <linux/slab.h>
> >  #include <linux/spinlock.h>
> >
> > +/**
> > + * struct of_fpga_region_priv - Private data structure
> > + * image.
> > + * @dev:	Device data structure
> > + * @fw:		firmware of coeff table.
> > + * @path:	path of FPGA overlay image firmware file.
> > + * @ovcs_id:	overlay changeset id.
> > + */
> > +struct of_fpga_region_priv {
> > +	struct device *dev;
> > +	const struct firmware *fw;
> > +	int ovcs_id;
> > +};
> > +
> >  static const struct of_device_id fpga_region_of_match[] =3D {
> >  	{ .compatible =3D "fpga-region", },
> >  	{},
> > @@ -394,20 +410,93 @@ static struct notifier_block fpga_region_of_nb =
=3D {
> >  	.notifier_call =3D of_fpga_region_notify,  };
> >
> > +static int of_fpga_region_status(struct fpga_region *region) {
> > +	struct of_fpga_region_priv *ovcs =3D region->priv;
> > +
> > +	if (ovcs->ovcs_id)
> > +		return FPGA_REGION_HAS_PL;
>=20
> Could you help specify what is PL?

We will replace "PL" (Programmable Logic) with FPGA_REGION_HAS_CONFIGURED
for better clarity.

> > +
> > +	return FPGA_REGION_EMPTY;
> > +}
> > +
> > +static int of_fpga_region_config_enumeration(struct fpga_region *regio=
n,
> > +					     struct fpga_region_config_info *config_info)
> {
> > +	struct of_fpga_region_priv *ovcs =3D region->priv;
> > +	int err;
> > +
> > +	/* if it's set do not allow changes */
> > +	if (ovcs->ovcs_id)
> > +		return -EPERM;
> > +
> > +	err =3D request_firmware(&ovcs->fw, config_info->firmware_name, NULL)=
;
> > +	if (err !=3D 0)
> > +		goto out_err;
> > +
> > +	err =3D of_overlay_fdt_apply((void *)ovcs->fw->data, ovcs->fw->size,
> > +				   &ovcs->ovcs_id, NULL);
> > +	if (err < 0) {
> > +		pr_err("%s: Failed to create overlay (err=3D%d)\n",
> > +		       __func__, err);
> > +		release_firmware(ovcs->fw);
> > +		goto out_err;
> > +	}
> > +
> > +	return 0;
> > +
> > +out_err:
> > +	ovcs->ovcs_id =3D 0;
> > +	ovcs->fw =3D NULL;
> > +
> > +	return err;
> > +}
> > +
> > +static int of_fpga_region_config_remove(struct fpga_region *region,
> > +					struct fpga_region_config_info *config_info) {
> > +	struct of_fpga_region_priv *ovcs =3D region->priv;
> > +
> > +	if (!ovcs->ovcs_id)
> > +		return -EPERM;
> > +
> > +	of_overlay_remove(&ovcs->ovcs_id);
> > +	release_firmware(ovcs->fw);
> > +
> > +	ovcs->ovcs_id =3D 0;
> > +	ovcs->fw =3D NULL;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct fpga_region_ops region_ops =3D {
> > +	.region_status =3D of_fpga_region_status,
> > +	.region_config_enumeration =3D of_fpga_region_config_enumeration,
> > +	.region_remove =3D of_fpga_region_config_remove, };
> > +
> >  static int of_fpga_region_probe(struct platform_device *pdev)  {
> >  	struct device *dev =3D &pdev->dev;
> >  	struct device_node *np =3D dev->of_node;
> > +	struct of_fpga_region_priv *priv;
> >  	struct fpga_region *region;
> >  	struct fpga_manager *mgr;
> >  	int ret;
> >
> > +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->dev =3D dev;
> > +
> >  	/* Find the FPGA mgr specified by region or parent region. */
> >  	mgr =3D of_fpga_region_get_mgr(np);
> >  	if (IS_ERR(mgr))
> >  		return -EPROBE_DEFER;
> >
> > -	region =3D fpga_region_register(dev, mgr, of_fpga_region_get_bridges)=
;
> > +	region =3D fpga_region_register_with_ops(dev, mgr, &region_ops, priv,
> > +					       of_fpga_region_get_bridges);
> >  	if (IS_ERR(region)) {
> >  		ret =3D PTR_ERR(region);
> >  		goto eprobe_mgr_put;
> > diff --git a/include/linux/fpga/fpga-region.h
> > b/include/linux/fpga/fpga-region.h
> > index 5fbc05fe70a6..3a3ba6dbb5e1 100644
> > --- a/include/linux/fpga/fpga-region.h
> > +++ b/include/linux/fpga/fpga-region.h
> > @@ -6,15 +6,35 @@
> >  #include <linux/device.h>
> >  #include <linux/fpga/fpga-mgr.h>
> >  #include <linux/fpga/fpga-bridge.h>
> > +#include <linux/fpga-region.h>
> > +#include <linux/miscdevice.h>
> >
> >  struct fpga_region;
> >
> > +/**
> > + * struct fpga_region_ops - ops for low level FPGA region ops for
> > +device
> > + * enumeration/removal
> > + * @region_status: returns the FPGA region status
> > + * @region_config_enumeration: Configure and enumerate the FPGA region=
.
> > + * @region_remove: Remove all devices within the FPGA region
> > + * (which are added as part of the enumeration).
> > + */
> > +struct fpga_region_ops {
> > +	int (*region_status)(struct fpga_region *region);
> > +	int (*region_config_enumeration)(struct fpga_region *region,
> > +					 struct fpga_region_config_info *config_info);
>=20
> My current concern is still about this combined API, it just offloads all=
 work to low
> level, but we have some common flows. That's why we introduce a common FP=
GA
> reprograming API.
>=20
> I didn't see issue about the vendor specific pre configuration. They are =
generally
> needed to initialize the struct fpga_image_info, which is a common struct=
ure for
> fpga_region_program_fpga().
>=20
> For port IDs(AFU) inputs for DFL, I think it could also be changed (Don't=
 have to be
> implemented in this patchset). Previously DFL provides an uAPI for the wh=
ole
> device, so it needs a port_id input to position which fpga_region within =
the device for
> programming. But now, we are introducing a per fpga_region programming in=
terface,
> IIUC port_id should not be needed anymore.
>=20
> The combined API is truly simple for leveraging the existing of-fpga-regi=
on overlay
> apply mechanism. But IMHO that flow doesn't fit our new uAPI well. That f=
low is to
> adapt the generic configfs overlay interface, which comes to a dead end a=
s you
> mentioned.
>=20
> My gut feeling for the generic programing flow should be:
>=20
>  1. Program the image to HW.
>  2. Enumerate the programmed image (apply the DT overlay)
>=20
> Why we have to:
>=20
>  1. Start enumeration.
>  2. On pre enumeration, programe the image.
>  3. Real enumeration.
>=20

I agree with the approach of leveraging vendor-specific callbacks to handle
the distinct phases of the FPGA programming process.=20
Here's the proposed flow.
=20
Pre-Configuration:
A vendor-specific callback extracts the required pre-configuration details
and initializes struct fpga_image_info. This ensures that all vendor-specif=
ic
requirements are handled before proceeding to the programming phase.
=20
Programming:
The common API fpga_region_program_fpga() is used to program the image
to hardware. This standardizes the programming logic, minimizing duplicatio=
n
and ensuring consistency across implementations.
=20
Enumeration:
A vendor-specific callback is used for real enumeration, enabling hardware
specific customization while keeping the flow flexible and adaptable

This approach provides a clean separation of responsibilities, with
vendor-specific logic confined to the pre-configuration and enumeration
phases, while the programming phase leverages a common API.
It simplifies maintenance and aligns well with the Program -> Enumerate flo=
w.
=20
Looking forward to your feedback.


Regards,
Navakishore.

