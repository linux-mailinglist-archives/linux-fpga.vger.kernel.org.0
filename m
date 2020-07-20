Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F9B225AE1
	for <lists+linux-fpga@lfdr.de>; Mon, 20 Jul 2020 11:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgGTJJk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 20 Jul 2020 05:09:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:48464 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTJJj (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 20 Jul 2020 05:09:39 -0400
IronPort-SDR: 8NgU/pELvTP8hPY/VGwBQ1WPJCi4DtEpHgJGJL3QwBZ/VZIKxDuWB+yvm0P2neVlra7fDqGly1
 Kbu0sH1zTITA==
X-IronPort-AV: E=McAfee;i="6000,8403,9687"; a="168007619"
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; 
   d="scan'208";a="168007619"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 02:09:38 -0700
IronPort-SDR: 1e/zOnILWmNDzVr5tVWFXyrmK7buUUWGo0VdXsKk5SBXWv5uqCciQF7Ff0yGCJdzjB8rHO7h/y
 3qFl8E0T7SPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; 
   d="scan'208";a="487659001"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga005.fm.intel.com with ESMTP; 20 Jul 2020 02:09:38 -0700
Received: from fmsmsx117.amr.corp.intel.com (10.18.116.17) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Jul 2020 02:09:38 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx117.amr.corp.intel.com (10.18.116.17) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Jul 2020 02:09:38 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.55) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 20 Jul 2020 02:09:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGGOgzCZMbQGfTZJRKRfXfAfk11gqpOc6KqlqxaElobK0X9oHeegq5x0fyDfNaOQW4g4upUSt3Kg++RtPvSUQuXdTd7a66V6xk6R6rCq5KtINOvTiKbQ9irlSwlQJLhyJcsFzaXpLuN4243aTsyOZeTwKUycQE14rwRDBi/vVjhp9wEBgJWa0G1oOZahWcQppBLSh0eTSmmLTQZsYV4DbqciCHwM/M5pV89iYjXVIIZ1Ahm6hm6UzXoUHjgX0bDAeCQGS4L2LYe3wbKQlzfIx9QPweSmrSHiNAi3k2oQCv3v+Q7digor/I7aJS8/soLayC6Kb0M6MEFqRQ2TiHGolA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJBaW5rRpdYh9HU5C3UM4O4oiLpeZOSGAlW2r67KOIA=;
 b=EKwRHn+UU5AFtiGvxceC0/osATM91G+rxshMoMXIHlMKlJFZs32fJ8P1ScClRLgs+rifzeMFbS8mwbtIZfCh8Du8BvaOlUzGkjQ0Ykw61FKGUezuSuEpeyUaIbCfAysXJ63tTH99me4PZzxpDwGBZT7VjNjWrmI+x1t/rdF78Kf+IYm49TZu7DFw6RW2piLOu68izzjc5TrVBIlsGDk1Se8qvSlBVgw3r/UvT/WZcYWPZ6RI1r7gXkqrfnHbrjG9/LdAGsmRfQqzka0kq2Yi4kdplcJaNjWOmSZBPpbqojjs8dnARj6nD2bkRIFwMZMp/uAZjJ+evGsvH5JgS9Sn7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJBaW5rRpdYh9HU5C3UM4O4oiLpeZOSGAlW2r67KOIA=;
 b=hc5Z4coSWyP3XCYrcVReEVqFDpMT5aYfUr+Yi3TGlmNvd6z5rrfQplLXV7foHD1Nn/J2clY6tgM2RF+BaE5IfARLKH8Dm8g+f0o6vu3qzxYzqSTbvikmKTyw8YwDRUC2YZG6EI8GrnEJ0Qp9jOEJTYoSdT5zHksIbJTeaSoyjCs=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3243.namprd11.prod.outlook.com (2603:10b6:5:e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.25; Mon, 20 Jul 2020 09:09:35 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a%4]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 09:09:35 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: RE: [PATCH 1/2] fpga: dfl: map feature mmio resources in their own
 feature drivers
Thread-Topic: [PATCH 1/2] fpga: dfl: map feature mmio resources in their own
 feature drivers
Thread-Index: AQHWWmrG+e8QO0ma10awRmLMwWLFs6kQNNDw
Date:   Mon, 20 Jul 2020 09:09:35 +0000
Message-ID: <DM6PR11MB381928806B8E65BEEF66D07F857B0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1594791498-14495-1-git-send-email-yilun.xu@intel.com>
 <1594791498-14495-2-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1594791498-14495-2-git-send-email-yilun.xu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7e21ec3-cfa5-4574-d282-08d82c8c9f83
x-ms-traffictypediagnostic: DM6PR11MB3243:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3243745371A5C17F45B831D1857B0@DM6PR11MB3243.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oC34j0KnP9811cGs6ysN63cwtoseLhVhBQ+29gEFx3PH5uY1JqXNVusNcCdjiGYXDVwUqNQcEWJcIowwqV1m6kIHmEnKbhQZ0XIJUI9P0zysX96w+B/n+RxCmUGiGB45c5m53KwVJEPL+xDWDyBLBi08cvreM1yvdFyfqH9cUlZyTmBzXdSYC9h2r70j151zeqFCcVGtYykSAQBKHAgYrUL/eTujM9uieg0Zba/2EK02An5fIapT3l6GUi+tmprV+OhAIR0LQgeOyxGoUsAsqTnXuOpGX6tIaV6AqDay/4SImxFFOpscvDlDqxaF71MS7MqlPTfDYXT4ZE+w2PGlEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(54906003)(33656002)(86362001)(66946007)(110136005)(66476007)(64756008)(66556008)(66446008)(83380400001)(52536014)(6506007)(26005)(5660300002)(8676002)(76116006)(9686003)(8936002)(4326008)(55016002)(186003)(2906002)(478600001)(7696005)(316002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: CZusk/xu25cU0ZQfrapU6E93gJHW2RVkS14rcyU50aUxMIMUN+e2euYCy1rXGm8MZqYyT0eoHjY4zJCnTc3NaxtDkcYHLxSLGRbV578u39n4KGAzkYGao+PDZAhX4fgWyEJ+95lgXUDKX/uVC3EGzFuAmg+ok0DbkE8S2Q8SIDNHqvgJZIr44X7pGqqXoCR3vc+1Gel3FiilC6S1+K8McwMDKQBqvz/zBgHgkgA8leAUyjOSVAI2WEXfiPcHog2D7adUfmpdit8dfQ+vvSig7WvIla1mm2e+WTBAkvJ/P1DYRZYw5UvsIuXsBm8EKbP1FV35FahfL2FOyva6j0xODG4yG+eLOPDZVMF/3ocTqDU55pgO4uL5BR11B2GYz/vZxQinoukzktVUFTy6o304HiTRgMPZY0vPXBXNZz46mFmR0mZ6YyAwE8FQsftxmUflMntF/u4KehS+BQ/N7PFUAf2CMZogakYaCafin3WL6x1alxgBbFK/RIlTL2Dn19EY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e21ec3-cfa5-4574-d282-08d82c8c9f83
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 09:09:35.4086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NbxJd3aocvteHn0JzVQScovHveOeWh3GB8q+Bm4pCjKMTU2yzjRZFAGcJR6v7EBR7bRZbEl0uWvQjSWdoOqOgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3243
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH 1/2] fpga: dfl: map feature mmio resources in their own
> feature drivers
>=20
> This patch makes preparation for modularization of DFL sub feature
> drivers.
>=20
> Currently, if we need to support a new DFL sub feature, an entry should
> be added to fme/port_feature_drvs[] in dfl-fme/port-main.c. And we need
> to re-compile the whole DFL modules. That make the DFL drivers hard to be
> extended.
>=20
> Another consideration is that DFL may contain some IP blocks which are
> already supported by kernel, most of them are supported by platform
> device drivers. We could create platform devices for these IP blocks and
> get them supported by these drivers.
>=20
> An important issue is that platform device drivers usually requests mmio
> resources on probe. But now dfl mmio is mapped in dfl bus driver (e.g.
> dfl-pci) as a whole region. Then platform device drivers for sub features
> can't request their own mmio resources again. This is what the patch
> trying to resolve.
>=20
> This patch changes the DFL enumeration. DFL bus driver will unmap mmio
> resources after first step enumeration and pass enumeration info to DFL
> framework. Then DFL framework will map the mmio resources again, do 2nd
> step enumeration, and also unmap the mmio resources. In this way, sub
> feature drivers could then request their own mmio resources as needed.
>=20
> An exception is that mmio resource of FIU headers are still mapped in dfl
> bus driver. The FIU headers have some fundamental functions (sriov set,
> port enable/disable) needed for dfl bus devices and other sub features.
> They should not be unmapped as long as dfl bus device is alive.
>=20
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  drivers/fpga/dfl-pci.c |  21 ++++--
>  drivers/fpga/dfl.c     | 187 +++++++++++++++++++++++++++++++++++--------=
---
> ---
>  drivers/fpga/dfl.h     |   6 +-
>  3 files changed, 152 insertions(+), 62 deletions(-)
>=20
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index e220bec..22dc025 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -39,6 +39,11 @@ static void __iomem *cci_pci_ioremap_bar(struct
> pci_dev *pcidev, int bar)
>  	return pcim_iomap_table(pcidev)[bar];
>  }
>=20
> +static void cci_pci_iounmap_bars(struct pci_dev *pcidev, int mapped_bars=
)
> +{
> +	pcim_iounmap_regions(pcidev, mapped_bars);
> +}
> +
>  static int cci_pci_alloc_irq(struct pci_dev *pcidev)
>  {
>  	int ret, nvec =3D pci_msix_vec_count(pcidev);
> @@ -123,7 +128,7 @@ static int *cci_pci_create_irq_table(struct pci_dev
> *pcidev, unsigned int nvec)
>  static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
>  {
>  	struct cci_drvdata *drvdata =3D pci_get_drvdata(pcidev);
> -	int port_num, bar, i, nvec, ret =3D 0;
> +	int port_num, bar, i, nvec, mapped_bars, ret =3D 0;
>  	struct dfl_fpga_enum_info *info;
>  	struct dfl_fpga_cdev *cdev;
>  	resource_size_t start, len;
> @@ -163,6 +168,8 @@ static int cci_enumerate_feature_devs(struct pci_dev
> *pcidev)
>  		goto irq_free_exit;
>  	}
>=20
> +	mapped_bars =3D BIT(0);
> +
>  	/*
>  	 * PF device has FME and Ports/AFUs, and VF device only has one
>  	 * Port/AFU. Check them and add related "Device Feature List" info
> @@ -172,7 +179,7 @@ static int cci_enumerate_feature_devs(struct pci_dev
> *pcidev)
>  		start =3D pci_resource_start(pcidev, 0);
>  		len =3D pci_resource_len(pcidev, 0);
>=20
> -		dfl_fpga_enum_info_add_dfl(info, start, len, base);
> +		dfl_fpga_enum_info_add_dfl(info, start, len);
>=20
>  		/*
>  		 * find more Device Feature Lists (e.g. Ports) per information
> @@ -200,22 +207,26 @@ static int cci_enumerate_feature_devs(struct
> pci_dev *pcidev)
>  			if (!base)
>  				continue;
>=20
> +			mapped_bars |=3D BIT(bar);
> +

One more place,

As you removed base addr usage below, so ideally we don't need to map
more bars for port here? is my understanding correct?

>  			start =3D pci_resource_start(pcidev, bar) + offset;
>  			len =3D pci_resource_len(pcidev, bar) - offset;
>=20
> -			dfl_fpga_enum_info_add_dfl(info, start, len,
> -						   base + offset);
> +			dfl_fpga_enum_info_add_dfl(info, start, len);

Thanks
Hao
