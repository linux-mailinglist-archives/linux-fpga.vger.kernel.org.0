Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10BE577A2B
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Jul 2022 06:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbiGREng (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 18 Jul 2022 00:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiGREne (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 18 Jul 2022 00:43:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F9C12A9D;
        Sun, 17 Jul 2022 21:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658119414; x=1689655414;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=N5hR0VJNEv3XBLF/FaJnsU5tNoeCfsUy+x2NnIVfVm0=;
  b=fC+FAHmN7fk0MM7vzeTUjzakhz5BvjRPfLCAoBmXKWpd5XSi901oCeQL
   gKg+wyBAOIaIULDAygyV+LHfZjJnmsRK3eMGLvgmjtKJIPHqyytxBYn3s
   0PzB8cvH1zrN+VNTBT+RNw7lCCVxVb2bZX7Hiv+go3xPQKasME9naVdoV
   ggf5NjFj7mnU+kvHtuBetXqZ3fXeDee3DahG1UaJSkRXi5QbGms+O4GOo
   glCvl+UZ/APdVXI3GWiVtHFp+sy9a/H8HcXO88md6/6Xqwtd6ULY8ABcv
   Qf+dieNA+/Q4H1C5EfUaCVfY6atxZqzo3zOwcYNBYM2ve4Or+l4kbM+8F
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="347819562"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="347819562"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 21:43:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="699896746"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jul 2022 21:43:32 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 17 Jul 2022 21:43:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 17 Jul 2022 21:43:32 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 17 Jul 2022 21:43:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfTA6ywyT7XGNISielSGiE3xvK2RUtlw5HFznkfA/T+PX9NUAQEEZmolhTaBkRxbpNqdynt2XHFCzsT4nF1rdqKliAkeS+3vTMg0ITn20TKqyVy//EmDk/iSnHCW2ZEQ5yV3xRZC6vG04x8kgjrbEgkZehSv9AHH2QIhJhAFfoErea4TWwmo6ulQdxnjoHjR3ZevpyP/gz1jZ1HPXTjcGcDnD8R+DaXhZH/whQeZXptfbcuuBK4f15Jwt321eoidVX99aCg8JdXwhAjkcRjVZm9sslZvPoi2bykYFn64KAKhVKEINkZ0soIOt6R3o4WUG4gdLJAeV1GgIFrwDPYzNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYJbESf9hCB9xguaXxJUpQ+LN9sTN9OJTLPGH1TRpZk=;
 b=hgAxmynnBoT7xhD+CYHCsIFIUWaDD6AzoZEFpBEmrOU180YlwpI6tq/f9E9vqZv5wGUOSg7s1eWfdH9qFc4W6bqgLwaZp3S0A6gJNWbD02pBzd7j16csVhWFCYFH3hd22TThxwnWf7EGghXeJz9dxKeaSMm8BmYhsk9PxmngmJCAdnJ/1bjLqsY3/7BcH4sF7+Ohk9lHYCm219FKSegyex/vJsp2sztFe4182n3AnUbXaQ4R0dgnN5/YeRynMVFVSXvzM/yGv1oB1cfP2x9DHgwD0G4Y9XxQ57do26nTBw0LgMoHSd59raYKIJFMLFvGGl7ndpdxE4ZN9tV+Kwc6PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by SA2PR11MB5179.namprd11.prod.outlook.com (2603:10b6:806:112::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Mon, 18 Jul
 2022 04:43:30 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::cba:2a0b:8dbe:ca9c]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::cba:2a0b:8dbe:ca9c%7]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 04:43:30 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "Muddebihal, Basheer Ahmed" <basheer.ahmed.muddebihal@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhang, Tianfei" <tianfei.zhang@intel.com>
Subject: RE: [PATCH v3 1/2] Documentation: fpga: dfl: add PCI Identification
 documentation
Thread-Topic: [PATCH v3 1/2] Documentation: fpga: dfl: add PCI Identification
 documentation
Thread-Index: AQHYkhMU6zFkOPO1zUS4PegFsTjVE62DmZbQ
Date:   Mon, 18 Jul 2022 04:43:30 +0000
Message-ID: <DM6PR11MB3819DEC352F9AE313FE340D9858C9@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220707150549.265621-1-matthew.gerlach@linux.intel.com>
 <20220707150549.265621-2-matthew.gerlach@linux.intel.com>
In-Reply-To: <20220707150549.265621-2-matthew.gerlach@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a31e401f-f453-4f63-92d8-08da68781040
x-ms-traffictypediagnostic: SA2PR11MB5179:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WBjfB1HR4BOLwxkHq02hmPV09ayD5ssGtpwDIIpvMFxe1tEgZF9/eS48+2Ke40uWM26n+Xb8KSOZ9/7eN8N1K5VLoZkeKjIBN8HvHcuHU4ZleWnNkQhL4GUuidyVCGVsZz1BaLcPzY4+kr+6GfrnBPLiy9fhAJrpNu8q7NxdaRKNSBUcZxoPysxt+0Kv5gVXQA5pMWkbE0WvzZi4NFEq7kz+igZc05DPgKlo1xu6s8FcRzxP3pIzek580glndVAV1pzmZf1H+4wYQAM9kxSLgNuLIDBViDocM9o3ND7NxFgAOsSqXLxljbiQXSmDFpbq/hKjr/j+xxlCHC+W3uG+8EPFBzTtLJr3u1Eo3M2CrHAHtlEX/Dgzc79DFH+0b12F8X8nmvkF6xqknDrZncI9Y+nVnYfMY7gplypggz26iFdL9y/gAkvTiIacrkrTEu2HpJbQh9Ot187GxPS5uTNeZIZKG7Hj28ltVRqzpx0tY2dHEZDANxJyIMN4WWq0PibR5yq/TJ2tI5F3peDYssF2vTMqRcP4xeBMbmNo7tuZAlVi5j8o77iUUWe6UdUghNO2gduUOf6zIvJAXWDXAcKwbdw42ayz9P6VHZqs0JhCFI3NIo4vux6Tk0mIW25xizh53CN99EqvtgvBAbTj11D2od/uuwXJ08e1AtgOse0P/rBxfoa4EssvGghEnEK9kpm3l0Nk34nixGxEzppMYt0yHOruFGiG4nDBw9sO48M6Graoa18YVixlB0ST+ZK7tUiPYR/LEfp4KZWGQYuEMQitwHxEfBIuGg2G3dDfZ0A/qPPBm0Pm0PXXPjQZhN2Y4OUd85E6MmLLAaO0DvLPPKJxFwL68RvnhFlb5y6HbqdNY8Q4jgSuwBz99uk2u+iefIAS+ShN3oeE0bvsr2VOx76OKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(39860400002)(346002)(366004)(376002)(2906002)(6636002)(52536014)(5660300002)(8936002)(186003)(66946007)(66556008)(316002)(86362001)(8676002)(76116006)(64756008)(66446008)(66476007)(71200400001)(33656002)(55016003)(478600001)(41300700001)(6506007)(7696005)(53546011)(26005)(966005)(110136005)(9686003)(38070700005)(83380400001)(122000001)(38100700002)(921005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZwzE3BMSLEzN8IJ+K/8a0HO6uXOHK8eqiN6JtvMb8nhO3P3/0goILxKYe5Su?=
 =?us-ascii?Q?pjR3yNkWCIF6gpmcpqu2zb7TZ6IjV0X4LDb4uTwRuBfmUoVniHvhp1eLatF9?=
 =?us-ascii?Q?1YJqXktwMdpVfQR0EYbfHLjImqwbQFVCBN3VucfhC+a+dkd0uGkOJHpK59ka?=
 =?us-ascii?Q?FoSzE47WDMFYR7zVJV2Xyx5SHwk1Zyp/jT3f/0o4CotWg8CibjZnSjfbxvEq?=
 =?us-ascii?Q?xMD2hD8Lx5daC+6SixFnkh1bYXcAMyrz4QWq1c+YcasY0jOJOdaSXzlWsKXL?=
 =?us-ascii?Q?Ie8RQNv0FAu1SG3Io1FA8gZRtI/orDmk7ssoRmtlCDLcjwFnmiJfhiewcLgB?=
 =?us-ascii?Q?RN7bdQGAmVuZ0LQz5PoKiCHVCZXi03/OB+GmETSVhLVj8Jb2t0HRNUM72dli?=
 =?us-ascii?Q?xZeDY+4fSr0iI0W4il6JmJmYl2MGRZVXJz7HJ5aQBWC3/T3INwLQ3iMvBFK4?=
 =?us-ascii?Q?qHSuXToN/tnTNVLlnM4Xc/V1m+qnmfOXw6USgBM9QaIrXLiJktX7ih/GhNpj?=
 =?us-ascii?Q?t6xJsdjs4sB/AYT5XAu8ZZIG1eNUNWyEoM3xyvt0IB5oV9/7v+3MF7OHdZxk?=
 =?us-ascii?Q?6I0HXbAFYLW+yRI8Ox6HPGSozzQgaGlZd9/JUkNwhD5DzRyNwGaGRCcLvgBj?=
 =?us-ascii?Q?ac4cj58QnLHtv+F8CUyw+sdmRkjU5TvV9UwblyqCLuAhz8CQpULamGlNci6O?=
 =?us-ascii?Q?ITgz1v84n88X05k9oBL3scLu/NOd3q9kfSo5TSScwp1xxvVAo0bUgA5Uh+UY?=
 =?us-ascii?Q?vwM5m4iW2Kg6egnWC/E7ttq/PNOccUaw7TRVIQF8KGonjtCAYRye5u8J3Ad0?=
 =?us-ascii?Q?6H5l9yTl72vfsToxNLxIZBDvT5LlEK5ZIrB641/7uz06ujJytA03dSL/m7M0?=
 =?us-ascii?Q?ZOWRwfU9S6gy3e3/0wwxRAzTwoededPo1eR44XyyiEaTghyUEy8TncjmgNWX?=
 =?us-ascii?Q?vhAA6M4DvRB32MtTTSE0BEPcHC1DGo9SEKWvNvEb/J5+ZYp55oU6HOMZMbKk?=
 =?us-ascii?Q?XDkBAEVscLej3mFN+XtfFqe6CQYm8Uq2BXn3io6dU/Fuhs67x84OEgzcH8Os?=
 =?us-ascii?Q?0WMkIQrCOONLrrANpp+IVvYwwhGZktmDkkBi1lxpeL9sbuklBd3lxaiTfk/n?=
 =?us-ascii?Q?E6F8RkPnEydutLusHPMHIvILbwgROuDPwVjwefsUJA/9HyYpCmkuMsqc14tM?=
 =?us-ascii?Q?T3gKaZGvBpFGxtBjKwt7m3DtU5HeppLzT7zaMTc/J5JS3f0GAGqJJrF31kmy?=
 =?us-ascii?Q?aysLYjFAdPCo3asOwqFa0dbpLVYESGkA4PMm6yvx8ZlQDBvGkizKWicekSb3?=
 =?us-ascii?Q?qC7V/dLdgN09lwNUy1Bfh5WavRTpBK6Md761lnIwU3kRD5pdZUkOhx+Pmqwh?=
 =?us-ascii?Q?2gkqMFGgHhVzVmXYGUJ/KrScEIA+kzxrZpQ4D762sELrAaIEs/3SPXso8Hys?=
 =?us-ascii?Q?jzRXFu75bd9an13w0NEsxHhbsTvPcSJdWaLIC5M7paCFng4M4fcdt0tPzKI9?=
 =?us-ascii?Q?lhJJROwLLC2dwjkyHvV496SA3czpNghWXbkCkM9E5IsylDBQDT5qZl7HT91D?=
 =?us-ascii?Q?sBC0SyrLN78Wh7DSQVY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a31e401f-f453-4f63-92d8-08da68781040
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 04:43:30.4221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UkUDa4MuO1TCcpVT0utn9NAFng5pQjN3nRFi+Fog3/ws/p7xBpJWTJmrpJ/t30NVVchPBCMjtF7GkcHMwyTFWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5179
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> -----Original Message-----
> From: matthew.gerlach@linux.intel.com <matthew.gerlach@linux.intel.com>
> Sent: Thursday, July 7, 2022 11:06 PM
> To: Wu, Hao <hao.wu@intel.com>; Xu, Yilun <yilun.xu@intel.com>; Weight,
> Russell H <russell.h.weight@intel.com>; Muddebihal, Basheer Ahmed
> <basheer.ahmed.muddebihal@intel.com>; trix@redhat.com;
> mdf@kernel.org; corbet@lwn.net; linux-fpga@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; Zhang, Tianfei
> <tianfei.zhang@intel.com>
> Cc: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Subject: [PATCH v3 1/2] Documentation: fpga: dfl: add PCI Identification
> documentation
>=20
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>=20
> Add documentation on identifying FPGA based PCI cards prompted
> by discussion on the linux-fpga@vger.kernel.org mailing list.
>=20
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v3: Add url to page tracking PCI ID information for DFL based cards.
>=20
> v2: Introduced in v2.
> ---
>  Documentation/fpga/dfl.rst | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index 15b670926084..5144775b860a 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -507,6 +507,27 @@ ids application.
>  https://github.com/OPAE/dfl-feature-id
>=20
>=20
> +PCI Device Identification
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +Since FPGA based PCI cards can be reconfigured to a perform a completely
> +new function at runtime, properly identifying such cards and binding the
> +correct driver can be challenging. In many use cases, deployed FPGA base=
d
> +PCI cards are essentially static and the PCI Product ID and Vendor ID pa=
ir
> +is sufficient to identify the card.  The DFL framework helps with the
> +dynamic case of deployed FPGA cards changing at run time by providing
> +more detailed information about card discoverable at runtime.
> +
> +At one level, the DFL on a PCI card describes the function of the card.
> +However, the same DFL could be instantiated on different physical cards.
> +Conversely, different DFLs could be instantiated on the same physical ca=
rd.
> +Practical management of a cloud containing a heterogeneous set of such
> cards
> +requires a PCI level of card identification. While the PCI Product ID an=
d
> +Vendor ID may be sufficient to bind the dfl-pci driver, it is expected
> +that FPGA PCI cards would advertise suitable Subsystem ID and Subsystem
> +Vendor ID values. Further PCI Product, Vendor, and Subsystem id tracking
> +can be found at https://github.com/OPAE/dfl-feature-id/blob/main/dfl-pci=
-
> ids.rst.

I feel that we may not really need this in fpga-dfl doc, as this is not des=
cribing
any new method provided by DFL, but just something from PCI standard, right=
?

Thanks
Hao
