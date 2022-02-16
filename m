Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806DA4B7E95
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Feb 2022 04:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344337AbiBPDfR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Feb 2022 22:35:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344334AbiBPDfQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 15 Feb 2022 22:35:16 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416ADFFF84;
        Tue, 15 Feb 2022 19:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644982505; x=1676518505;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sxT4WAUsPFZ3nlbu2IvTeY5u79FGEr7KlzTLAnEg65k=;
  b=hzLLQsV7Qj7XD0jJJKnega3KUqaprsSZLLEBHN/qEk8p3QanzQ5hsSTe
   qxrAAfIgzq2D/pYq9gi3SSKMeNFj3KIVsNG2ChnTuucppS13X1ZjiRBbb
   kZQGJoCr6et3HcyvExT6/2OOltOT9c3GqP6r3M2+dvIl781RW7+jOAn6F
   Tg3ZbWb5LwSG2X4sbSxzn7sLK+s5EDNvD4djRqoK9DLD5h3vsMwP+KQQV
   rY4i/88AbWzG6qHWik4e+q1xwputZRRpjbEgijdCOe7QggXB3p7+qknfY
   jVlJOQsIKpjfRlJtZ56HVad8toI1+r3Ur6ry0fAIDvwQGObycB2EVAK01
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="250715358"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="250715358"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 19:35:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="486633670"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga003.jf.intel.com with ESMTP; 15 Feb 2022 19:35:04 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 15 Feb 2022 19:35:03 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 15 Feb 2022 19:35:03 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 15 Feb 2022 19:35:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrzIyUztFkPs8VfBvN2YYtgGG7zXv1ZeoayqA/u1UtSgruCUAMFR82tMVK3xdMZQg6HkeDTeLhDgCslQvf6FomqjE3TfGgfxzN1Swsm6ibaOz5SlJO/EfEb4RrMVUV9V911r7Bbgc660pI2S7zZQJxCrKNcCWTMy1qT3Iab8227s/ssJoz0jJ0/7DpES7qVyF++xY6PK0kl4aIM8Ygj2fvbsdGViyYE+mwmN3bBYthS4opmEDHd0Nebf/vYaYcy2JzgYZEb0FUlAjS8gy1uZIATJlFqrxF8klgIX8ILUt8ahN+g7ggmVCMQm+zLYgA3oX3ScoTM/Kl4MiMPCPTvgYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jl4ZD1pnLYwQlaZJfTaHNmlXysrOqgpsZV6kebu0HNg=;
 b=S3CZBeHtnW7lxWNKouO+1Z+/t1/eNL2WlLBYB+vVT2px7MByt3MHkUOjVj1RKLY3H4yfedwXYK0tuJEp6dHkSh3g5404RoR81bWNKhv5yb61nuIIOn6bbz4JBHpppfPpNu+5szxLGf/AxI1CxJFwvKRABV/1jVTF10MC55sbLHDXF646L5dH2YvmLFT/Y6Nr7oBYB78RUFsM+8f3zj8CEfcY9WaoEXh7i5mpFqWRTEaiNCDJQKUzA3nzwugRoECIdNtUc/Cei8ln69Pj9dDDu7OU+Jpr7XS2xXCsMhaJ4aBEimF2zkhwS3RfhvUGt95n6cnep0KP518pD3OoEnNrKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM5PR11MB1625.namprd11.prod.outlook.com (2603:10b6:4:b::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.15; Wed, 16 Feb 2022 03:34:59 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d%3]) with mapi id 15.20.4975.017; Wed, 16 Feb 2022
 03:34:59 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH v1 1/7] Documentation: fpga: dfl: add description of IOFS
Thread-Topic: [PATCH v1 1/7] Documentation: fpga: dfl: add description of IOFS
Thread-Index: AQHYIZYrZwyldhqgpEacaXgZS6WQkayVf2AA
Date:   Wed, 16 Feb 2022 03:34:59 +0000
Message-ID: <DM6PR11MB381933DF77F512D7E70539EF85359@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-2-tianfei.zhang@intel.com>
In-Reply-To: <20220214112619.219761-2-tianfei.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b2d8335-135c-41ff-c434-08d9f0fd4f12
x-ms-traffictypediagnostic: DM5PR11MB1625:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR11MB1625291DB67584294730CDBF85359@DM5PR11MB1625.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vz01IbNk5VNjovYctLsSaJz+oe6Muca1IesOzqA08aS5h+HRV7B591RCWjrz7quQ+IiXZCkBGOa0XmYd56JmZn0bpXpTCDvBpTnznxnDJqI1a+39H9QTAmCWqiTF6gMacGkt0JbBQLEEbCExlGIHTk+h2f/ovdSdVCW85Ta+E4G50DkZaroAL38DEUGViNTay7mbMwbeB/GK2PIrSwfUmYntZ3bLox4vIrGNaqGn5Ow5+isC7PcFHmZpajDIcV9BSNtwB56+5jtk3MO+RBWwgKwxPvTkU2usmoG1IMgZfyZ1UC3aoRgwbqhEtR86DtF6bcmdx6r48Qud7PfC/RUXKvuYfUq3Itu1KZ7nlNaw3c7z+yENoGG0l2cEvgv0kFVKjUgHO3UZnyI8/yaQoFhOXnjwqDeV29Yhro8kXrcYlPioaynWzJg5Ft9uGKIsHCdclGZC6ODmnM7Olxy0UTJQ7ZNbc6LzJtFAAmedzMyRe2xjiEv7WZhRxUJEPWM9BR3C0KLlIdmCZRKw6Faf+NRwth9jldw4g8ZOxVAOTPeBGw2X3CeArJZPhDebP9onyxbyviHCLNFbsiQPVkmcc6UITqHEA1NFzvrVXXBW2J6TFWUQMSBh0crf6wUCny6swx7va2ID0XUAwTYvy5vLdZkNSCyieYaARO3H3NisG2hs5iZY+bGdt9WtrW8wVGIym1mmEgph6fL1b86MsB9MU2bc1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(38070700005)(82960400001)(4326008)(8676002)(110136005)(64756008)(66446008)(76116006)(8936002)(66476007)(66556008)(122000001)(38100700002)(5660300002)(316002)(66946007)(52536014)(71200400001)(7696005)(6506007)(83380400001)(9686003)(33656002)(26005)(508600001)(186003)(55016003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ERXvqg8GHXp25s0XFIDsk7xzBcNRsInqhr6lOS3q5kz6FHPqLoYgapWRkRs4?=
 =?us-ascii?Q?D5QDzvHIrS8DrQqFkWZIGzX5tq4Xb8s2YCOVkk9arxY/Dw1gLYtywQ6nmLRa?=
 =?us-ascii?Q?HnauTjeDJ0ERgWBSQDmWI1CcClDsUoHZhjtO2Djxc3CGx+sdpxvNbIoQ1x2f?=
 =?us-ascii?Q?y9NJNZlH5qevgK2M2uAD2xGU+ladZCIFfxc7dB89ht0pWFZNrW16O7btzjtV?=
 =?us-ascii?Q?Ga5iov9uVz3msAuASAJsGuk8mADM1gYvThMKLA7IN8YOzXASFsfLwZZMi11z?=
 =?us-ascii?Q?sYzvr7OVk36FgjgatgleVK6JU1znaFblvsAx2qcuf0K4AYGd3PTwymvvoB9J?=
 =?us-ascii?Q?t4YWOCPcsIfmRpg7v5DrgkImNcmBeYSZJ0C730OCOC/uItodsWxT1+EcIftu?=
 =?us-ascii?Q?jMzV6Bbz+C3e4zpvpp9Yx4O6g4vWtMoTTnWgFWNR4PQcZaGrsSf1Xv7zLrpM?=
 =?us-ascii?Q?qsEO2vyLHLbLDIaDKizJnF4thhABoIsoEVjC6Ry1LfhdqK1uOfgBohZuHBO8?=
 =?us-ascii?Q?qcZvNfhoBp/nL7mlLGizQD8jvdb+eJ+W0DyW9WRVsCrVTgEv5WOYTPRcpXR7?=
 =?us-ascii?Q?iykFTdNzsFS9x8+dqXuDCgu2Hmc9BaGGCmaHFe/Pbb9RAXVFYyhUoJfUSEjc?=
 =?us-ascii?Q?XSfWqiIv04ljUEdNL6ciNV3Dy5biLmGf1fGVcjgXLqNExWuEq08Usmknui1+?=
 =?us-ascii?Q?9m4sal2IUJ7okIRRKdKIjsZvxspgsmcwlnjPzucrIHej8wOKk2vhWgPHVbHd?=
 =?us-ascii?Q?iXgqX+d8lsjFdMk3cQGP02EjXURPne7aEjLC5zhsXUsEcOMwQOpXEUbEYhTs?=
 =?us-ascii?Q?r1aRrZ7sPG9rpHhcM9EDYi81A0Z1IQi4Fj3xxQRehsuuszoaVdUr8K45m9JE?=
 =?us-ascii?Q?LKdTlvYPwrDz6s+RX7lK/EQcjQQjtByXQgN50Bwnw56012v9mBc4kADbKvXq?=
 =?us-ascii?Q?j6QUPYIFeD+7z0/18RlTuhzyk81oAsTiz7AJQ0SIGnUK8ibkpVkIRdSolQFU?=
 =?us-ascii?Q?xAJPl3InbpNFai1TNzzQOxyVMavNefc/sGOOsnxO46pr2v7cweBlxrw7761P?=
 =?us-ascii?Q?cPwGoENkwSyrmMx/gtaoBI8gXZVVen8IL+eeoq83p7q5cJhqpff498Sr4zOD?=
 =?us-ascii?Q?1d/B9DTx7HggvWTcZ9oFgEVdqrtuomqWPlOZNlOKhnbD6XOXkenCCdLcH/hg?=
 =?us-ascii?Q?oG38i9ctoDBSSUp5HKHBtCnk8lqSA8r0T+Sul1v4y+40AZm52csDkB5ZxfKu?=
 =?us-ascii?Q?H0wnhLD33RPuAarYwAjmBxxzNtFV2T24NuQcl2p2qXKxbxjO6mm51CK8Aqoj?=
 =?us-ascii?Q?EjNbVD05uHeAj6BiElvNL2DIo7nLgBGkkCJVz9jqESxjGE86nviCC5P7TfiH?=
 =?us-ascii?Q?q+1lBzXNFjQsQbAJWie/e8uYBArvbmjjBN80k/WGT96Hxz9l7/JaCXEt+DPv?=
 =?us-ascii?Q?7dkyY9Ckq0CJV4aU58K59heTXsDy9/xS4g4kzdUH0aTgMcO0TtMO3T4CPZ+m?=
 =?us-ascii?Q?tB9na2U2Yk4s0f3EihF5j67/Y39GlwsvYucGIi77DtscoX7PCsMUFJtmL0Md?=
 =?us-ascii?Q?BjPn5e5+H8npiVuOWWCCaY1PR/BYbW15Yuj90ErYB1RMVpZ86sl4qgcZE6fw?=
 =?us-ascii?Q?9Pu8gVoXNszNcZxUl5nw3Lw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2d8335-135c-41ff-c434-08d9f0fd4f12
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 03:34:59.2876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 90a4YacVy8JQygQVzV33aB+b7fwYOunAcrnuMRSnNq+I2sY3p2CEe4uvPV+smDmSHQHgsr+uNl0VJt++Do+0ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1625
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v1 1/7] Documentation: fpga: dfl: add description of IOFS
>=20
> From: Tianfei Zhang <tianfei.zhang@intel.com>
>=20
> This patch adds description about IOFS support for DFL.
>=20
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>  Documentation/fpga/dfl.rst | 99 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index ef9eec71f6f3..6f9eae1c1697 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -58,7 +58,10 @@ interface to FPGA, e.g. the FPGA Management Engine
> (FME) and Port (more
>  descriptions on FME and Port in later sections).
>=20
>  Accelerated Function Unit (AFU) represents an FPGA programmable region a=
nd
> -always connects to a FIU (e.g. a Port) as its child as illustrated above=
.
> +always connects to a FIU (e.g. a Port) as its child as illustrated above=
, but
> +on IOFS design, it introducing Port Gasket which contains AFUs. For DFL
> perspective,
> +the Next_AFU pointer on FIU feature header can point to NULL so the AFU =
is
> not
> +connects to a FIU(more descriptions on IOFS in later section).
>=20
>  Private Features represent sub features of the FIU and AFU. They could b=
e
>  various function blocks with different IDs, but all private features whi=
ch
> @@ -134,6 +137,9 @@ reconfigurable region containing an AFU. It controls =
the
> communication from SW
>  to the accelerator and exposes features such as reset and debug. Each FP=
GA
>  device may have more than one port, but always one AFU per port.
>=20
> +On IOFS, it introducing a new hardware unit, Port Gasket, which contains=
 all
> +the PR specific modules and regions (more descriptions on IOFS in later =
section).

What's the different between the PORT we have now for DFH, and the new one
in IOFS?

> +
>=20
>  AFU
>  =3D=3D=3D
> @@ -143,6 +149,9 @@ used for accelerator-specific control registers.
>  User-space applications can acquire exclusive access to an AFU attached =
to a
>  port by using open() on the port device node and release it using close(=
).
>=20
> +On IOFS, the AFU is embedded in a Port Gasket. The AFU resource can expo=
se
> via
> +VFs with SRIOV support (more descriptions on IOFS in later section).
> +
>  The following functions are exposed through ioctls:
>=20
>  - Get driver API version (DFL_FPGA_GET_API_VERSION)
> @@ -284,7 +293,8 @@ FME is always accessed through the physical function
> (PF).
>=20
>  Ports (and related AFUs) are accessed via PF by default, but could be ex=
posed
>  through virtual function (VF) devices via PCIe SRIOV. Each VF only conta=
ins
> -1 Port and 1 AFU for isolation. Users could assign individual VFs (accel=
erators)
> +1 Port (On IOFS design, the VF is designs without Port) and 1 AFU for is=
olation.
> +Users could assign individual VFs (accelerators)
>  created via PCIe SRIOV interface, to virtual machines.
>=20
>  The driver organization in virtualization case is illustrated below:
> @@ -389,6 +399,91 @@ The device nodes used for ioctl() or mmap() can be
> referenced through::
>  	/sys/class/fpga_region/<regionX>/<dfl-fme.n>/dev
>  	/sys/class/fpga_region/<regionX>/<dfl-port.n>/dev
>=20
> +Intel Open FPGA stack
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Intel Open FPGA stack aka IOFS, Intel's version of a common core set of
> +RTL to allow customers to easily interface to logic and IP on the FPGA.
> +IOFS leverage the DFL for the implementation of the FPGA RTL design.
> +
> +IOFS designs allow for the arrangement of software interfaces across mul=
tiple
> +PCIe endpoints. Some of these interfaces may be PFs defined in the stati=
c
> region
> +that connect to interfaces in an IP that is loaded via Partial Reconfigu=
ration
> (PR).
> +And some of these interfaces may be VFs defined in the PR region that ca=
n be
> +reconfigured by the end-user. Furthermore, these PFs/VFs may also be
> arranged
> +using a DFL such that features may be discovered and accessed in user sp=
ace
> +(with the aid of a generic kernel driver like vfio-pci). The diagram bel=
ow depicts
> +an example design with two PFs and two VFs. In this example, PF1 impleme=
nts
> its
> +MMIO space such that it is compatible with the VirtIO framework. The oth=
er
> functions,
> +VF0 and VF1, leverage VFIO to export the MMIO space to an application or=
 a
> hypervisor.

So PORT will never be exposed to VM in IOFS design, is my understanding cor=
rect?

> +
> +     +-----------------+  +--------------+  +-------------+  +----------=
--+
> +     | FPGA Managerment|  |   VirtIO     |  |  User App   |  | Virtual  =
  |

s/Managerment/Management/

> +     |      App        |  |     App      |  |             |  | Machine  =
  |
> +     +--------+--------+  +------+-------+  +------+------+  +-----+----=
--+
> +              |                  |                 |               |
> +              |                  |                 |               |
> +     +--------+--------+  +------+-------+  +------+------+        |
> +     |     DFL Driver  |  |VirtIO driver |  |    VFIO     |        |
> +     +--------+--------+  +------+-------+  +------+------+        |
> +              |                  |                 |               |
> +              |                  |                 |               |
> +     +--------+--------+  +------+-------+  +------+------+   +----+----=
--+
> +     |     PF0         |  |     PF1      |  |   PF0_VF0   |   |  PF0_VF1=
  |
> +     +-----------------+  +--------------+  +-------------+   +---------=
--+
> +
> +On IOFS, it introducing some enhancements compared with original DFL des=
ign.
> +1. It introducing Port Gasket in PF0 which is responsible for FPGA manag=
ement,
> +like FME and Port management. The Port Gasket contains all the PR specif=
ic
> modules

So in IOFS, in PF0, we always have FME and PORT DFH, is my understanding co=
rrect?
Then why we need patch #3?

Another question is in IOFS, do we need to support multiple PR regions/Port=
s?
If that is the case, how should we know which VFs belongs to PORT1 or PORT2=
?

> +and logic, e.g., PR slot reset/freeze control, user clock, remote STP et=
c.
> +Architecturally, a Port Gasket can have multiple PR slots where user wor=
kload
> can
> +be programmed into.
> +2. To expend the scalable of FPGA, it can support multiple FPs in static=
 region

s/FPs/PFs/

> +which contain some static functions like VirtIO, diagnostic test, and ac=
cess over
> +VFIO or assigned to VMs easily. Those PFs will not have a Port Unit whic=
h
> without
> +PR region (AFU) connected to those PFs, and the end-user cannot partial
> reconfigurate

s/reconfigurate/reconfigure/

> +those PFs.
> +3. In our previous DFL design, it can only create one VF based in an AFU=
. To
> raise
> +the efficiency usage of AFU, it can create more than one VFs in an AFU v=
ia PCIe
> +SRIOV, so those VFs share the PR region and resource.
> +
> +There is one reference architecture design for IOFS as illustrated below=
:
> +
> +                              +----------------------+
> +                              |   PF/VF mux/demux    |
> +                              +--+--+-----+------+-+-+
> +                                 |  |     |      | |
> +        +------------------------+  |     |      | |
> +  PF0   |                 +---------+   +-+      | |
> +    +---+---+             |         +---+----+   | |
> +    |  DFH  |             |         |   DFH  |   | |
> +    +-------+       +-----+----+    +--------+   | |
> +    |  FME  |       |  VirtIO  |    |  Test  |   | |
> +    +-------+       +----------+    +--------+   | |
> +    | Port  |            PF1            PF2      | |
> +    +---+---+                                    | |
> +        |                             +----------+ |
> +        |                             |           ++
> +        |                             |           |
> +        |                             | PF0_VF0   | PF0_VF1
> +        |           +-----------------+-----------+------------+
> +        |           |           +-----+-----------+--------+   |
> +        |           |           |     |           |        |   |
> +        |           | +------+  |  +--+ -+     +--+---+    |   |
> +        |           | | CSR  |  |  | DFH |     |  DFH |    |   |
> +        +-----------+ +------+  |  +-----+     +------+    |   |
> +                    |           |  | DEV |     |  DEV |    |   |
> +                    |           |  +-----+     +------+    |   |
> +                    |           |            PR Slot       |   |
> +                    |           +--------------------------+   |
> +                    | Port Gasket                              |
> +                    +------------------------------------------+
> +
> +Here are the major changes about DFL structures on IOFS implementation
> design:
> +1. The Port Gasket connects to FIU Port in DFL, but the Next_AFU pointer=
 in
> +FIU feature header can point to NULL so that it is no AFU connects to a =
FIU
> +Port.
> +2. The VF which include in PR region can start with AFU feature header w=
ithout
> +a FIU Port feature header.

What about PF2 in static region? Which type of DFH will be used?

Thanks
Hao

>=20
>  Performance Counters
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --
> 2.17.1

