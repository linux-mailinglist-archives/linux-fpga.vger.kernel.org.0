Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F3623D277
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Aug 2020 22:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgHEUNK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Aug 2020 16:13:10 -0400
Received: from mga07.intel.com ([134.134.136.100]:9493 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbgHEQZD (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 5 Aug 2020 12:25:03 -0400
IronPort-SDR: 3TBBeG0ksyGEFgsxjMnNWVG2juGN6rYFYpNJtb97qkZZWuFn/sdSGFsoWnjZyqGyGqeShBUPod
 vvT/0oWiQioA==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="216885164"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="216885164"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 05:15:30 -0700
IronPort-SDR: G/agrABXE/Vafydcacp2C9yPF+tO5vtO7VJBwWm2YVgofpj6pMi8q7Js9GALzrK7tcRZl6Jzlp
 CPusf32kceoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="330914385"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Aug 2020 05:15:30 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 5 Aug 2020 05:15:29 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 5 Aug 2020 05:15:29 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.50) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 5 Aug 2020 05:15:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdMYV3S/nG25IULnrtjUJ5U8/Fk7NrgGpsyzJ7gxiDLUOZgenv1KdGHP9WQLjo10TLJLgWV4RHLyICW7ijPpHqOjCgjKZAv82vfyexD24HOQViiPP17FUpQbm29uMCkY9KaeHXB6c8/oiwXTJ5atCUfLeCZ6rF/T38/tTuntZC6esgofdqEJS6B0CXywvHAm0Ut2pTloAXlynUCxhTVh65nlAR8m9RQWDCeStJ8FIM+ed//7z74vx+jTJ1PbiW3OGtLGUZ9dCsfpWpT8UkmOKK5O0IkNOpYw+ldYVMkd+MTt6n7aYO7U1EnF/4OSBeeO7A2CKlsT2DPvobmwSw/tmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsB0ia/TvD6dJxVkrRiZrG1rrpsdbijcELPRJD8UYcc=;
 b=l0pcOePy0dhLJFMpi8bmoTTOhRykfW4CXZhUkqbjPpeM2I94Mkr+7aCtb1iQoONs3gYzPgsXVAtK14K6klouHTA2gWUfAy/N8JgF0QFsMdtG7Ep+pL3nn3blx/Y6sXdsKoLcT5Da6B7d/aAQNDXXqL9zuYSOh5bvfD4Cwxj+T7LRZ1IOhTtccu4OJIKOiRoqHX0cwbjH03vmkaeWQuyxiDNK/k+FbHc1AMIheyFNUopLYZpz7MMAo+yrtC3zUPAEtco1ME8J69If7ouWFAejJPPP662uPrUii2s0LdJJMNBbcT2OWxqujeouI4L4nURVU5LFBalwlH27afC1eJYkAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsB0ia/TvD6dJxVkrRiZrG1rrpsdbijcELPRJD8UYcc=;
 b=yKFz4/eMOukLmUVoTTNVwGrMPfxCsQaourWvOUZu9iAUfwrnKfzzSP6fSHFyUv8ZThWLzxJUTIoSKcLMeuFjtP9QfKlCdXy/2dgTeBdl/fvVAy6brTnEOLdHEwUcHZaZIJWiYkQSx25bPCuxmcaJzS+3pZVR5aTHaRydxOvDQIM=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3081.namprd11.prod.outlook.com (2603:10b6:5:6a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Wed, 5 Aug
 2020 12:15:27 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a%4]) with mapi id 15.20.3239.022; Wed, 5 Aug 2020
 12:15:27 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: RE: [PATCH v3 2/4] fpga: dfl: map feature mmio resources in their own
 feature drivers
Thread-Topic: [PATCH v3 2/4] fpga: dfl: map feature mmio resources in their
 own feature drivers
Thread-Index: AQHWai4pIUaKU42WjkmWcZUnUFXYOakpZRSw
Date:   Wed, 5 Aug 2020 12:15:27 +0000
Message-ID: <DM6PR11MB3819B8C6D19C351CC9366685854B0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1596524715-18038-1-git-send-email-yilun.xu@intel.com>
 <1596524715-18038-3-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1596524715-18038-3-git-send-email-yilun.xu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f33ab0c5-9278-4f2a-f1c3-08d839393d2a
x-ms-traffictypediagnostic: DM6PR11MB3081:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB308161AFDC8B629908F9BB17854B0@DM6PR11MB3081.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qoh9IjP7vyLPbKMc9SbQ6us0iX+EGdtjXXwUKbaF/gm9IIsr1nbMhwV/R/YGof5LEZ+Sl0nhAWbeHcbYNhDW9SGI4GNBhAtmBUuMoQi/w2C+l0Unkz5splol+N8iIXqkoT3M+sCr52HSBuv1OgQXiEFgo+W6QX1PgYdvEqRYYHwjRdENZa+8yogfWKm/alo5fKSD+BzJnswAAKQdPCRt1iPf29uqDXOEwElaKMTnJATfqWMaltOa61otQdeIUV7vxw8o/3OQU4QwHNORLz0Hy8f+CDLR7NK+WyFsNUIaV+4bFHCdQyFoSFT0RDiYmdR0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(33656002)(9686003)(186003)(71200400001)(4326008)(2906002)(8676002)(83380400001)(5660300002)(30864003)(26005)(8936002)(55016002)(6506007)(64756008)(66946007)(76116006)(66476007)(66556008)(52536014)(66446008)(316002)(7696005)(86362001)(110136005)(54906003)(478600001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Aa0eizAHD6e+aGZP1jX/RUztnwGZ5JuM0pztnmj8IMHluPLavPt6InxpauF+BeSXBHlyLh1vjmiUjarUSR8Phm1HtuAmTgvnQ6KY6SoyzTDO8ePTFj1EpM20j87euN39GxquB0DUh3QUmuDL00TRNhUnR3MeI7UVLJIwne3OKL+3LU7XphCevTjowN5tyCPRpg05LVd+9woyPtQHk0Gu0U7dGbgv8FmBiyCm9JpIKSA23VONgdvKxU81r57QAOyC3Ht1MTxcyIFUynU+O41BEsUxiEu+XVu2TEolrophL9oqaQ8ljW8TFjGs7BccbWbcOO508THMNbuZacbzpAyw53O1HSvfiWg+p12obG5wfn2BNenrrCX8bcmZcvAaiZxMqg5SHTrZcFAjECtNnaaEU14M8/RZ8/icI5q5wwRMZ3a8hBVT7GTQ8gE6J6ny78jB8UFDEt6jYqRVKsI8TnuFcuzB7oZo/lSw7e4bqjPgWSf9/OKbqBThZa+V9he5d+Rzdy+Lu8C4UPX+EIoFX+yCGgV029BdNSr3bCjaNTcTotkEm3UAmBEn5ZZwhXovoL+BPn9ucFennwSn/mgme6l6gJeOQEWgzhOaabIimNLqKtSacSy8FFmUDGcIC/buZyX07J01jpq/L6v0hpAVMqTTng==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33ab0c5-9278-4f2a-f1c3-08d839393d2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2020 12:15:27.3679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Zfyx9nrH/f3Ov3Dv8K2L8WYIFNYm7jA24uURhet0qfYuUXwU60kFqsF+4JsRg9EVgp3nKxA1ebd6dFN/kh6uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3081
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v3 2/4] fpga: dfl: map feature mmio resources in their ow=
n
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
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
> v2: delete dfl_binfo_shift() cause no shift is possible for FIU parsing.
>     Only map bar0 for first phase enumeration in dfl-pci, we can find
>       all dfl mmio resource info in bar0.
>     Some minor fixes for comments from Hao & Tom.
> v3: no change.
> ---
>  drivers/fpga/dfl-pci.c |  24 +++----
>  drivers/fpga/dfl.c     | 185 ++++++++++++++++++++++++++++++++++---------=
---
> ---
>  drivers/fpga/dfl.h     |   7 +-
>  3 files changed, 140 insertions(+), 76 deletions(-)
>=20
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index e220bec..a2203d0 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -31,12 +31,12 @@ struct cci_drvdata {
>  	struct dfl_fpga_cdev *cdev;	/* container device */
>  };
>=20
> -static void __iomem *cci_pci_ioremap_bar(struct pci_dev *pcidev, int bar=
)
> +static void __iomem *cci_pci_ioremap_bar0(struct pci_dev *pcidev)
>  {
> -	if (pcim_iomap_regions(pcidev, BIT(bar), DRV_NAME))
> +	if (pcim_iomap_regions(pcidev, BIT(0), DRV_NAME))
>  		return NULL;
>=20
> -	return pcim_iomap_table(pcidev)[bar];
> +	return pcim_iomap_table(pcidev)[0];
>  }
>=20
>  static int cci_pci_alloc_irq(struct pci_dev *pcidev)
> @@ -156,8 +156,8 @@ static int cci_enumerate_feature_devs(struct pci_dev
> *pcidev)
>  			goto irq_free_exit;
>  	}
>=20
> -	/* start to find Device Feature List from Bar 0 */
> -	base =3D cci_pci_ioremap_bar(pcidev, 0);
> +	/* start to find Device Feature List in Bar 0 */
> +	base =3D cci_pci_ioremap_bar0(pcidev);
>  	if (!base) {
>  		ret =3D -ENOMEM;
>  		goto irq_free_exit;
> @@ -172,7 +172,7 @@ static int cci_enumerate_feature_devs(struct pci_dev
> *pcidev)
>  		start =3D pci_resource_start(pcidev, 0);
>  		len =3D pci_resource_len(pcidev, 0);
>=20
> -		dfl_fpga_enum_info_add_dfl(info, start, len, base);
> +		dfl_fpga_enum_info_add_dfl(info, start, len);
>=20
>  		/*
>  		 * find more Device Feature Lists (e.g. Ports) per information
> @@ -196,26 +196,24 @@ static int cci_enumerate_feature_devs(struct
> pci_dev *pcidev)
>  			 */
>  			bar =3D FIELD_GET(FME_PORT_OFST_BAR_ID, v);
>  			offset =3D FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
> -			base =3D cci_pci_ioremap_bar(pcidev, bar);
> -			if (!base)
> -				continue;
> -
>  			start =3D pci_resource_start(pcidev, bar) + offset;
>  			len =3D pci_resource_len(pcidev, bar) - offset;
>=20
> -			dfl_fpga_enum_info_add_dfl(info, start, len,
> -						   base + offset);
> +			dfl_fpga_enum_info_add_dfl(info, start, len);
>  		}
>  	} else if (dfl_feature_is_port(base)) {
>  		start =3D pci_resource_start(pcidev, 0);
>  		len =3D pci_resource_len(pcidev, 0);
>=20
> -		dfl_fpga_enum_info_add_dfl(info, start, len, base);
> +		dfl_fpga_enum_info_add_dfl(info, start, len);
>  	} else {
>  		ret =3D -ENODEV;
>  		goto irq_free_exit;
>  	}
>=20
> +	/* release I/O mappings for next step enumeration */
> +	pcim_iounmap_regions(pcidev, BIT(0));
> +
>  	/* start enumeration with prepared enumeration information */
>  	cdev =3D dfl_fpga_feature_devs_enumerate(info);
>  	if (IS_ERR(cdev)) {
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 18575d9..c649239 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -250,6 +250,8 @@ int dfl_fpga_check_port_id(struct platform_device
> *pdev, void *pport_id)
>  }
>  EXPORT_SYMBOL_GPL(dfl_fpga_check_port_id);
>=20
> +#define is_header_feature(feature) ((feature)->id =3D=3D
> FEATURE_ID_FIU_HEADER)
> +
>  /**
>   * dfl_fpga_dev_feature_uinit - uinit for sub features of dfl feature de=
vice
>   * @pdev: feature device.
> @@ -273,8 +275,22 @@ static int dfl_feature_instance_init(struct
> platform_device *pdev,
>  				     struct dfl_feature *feature,
>  				     struct dfl_feature_driver *drv)
>  {
> +	void __iomem *base;
>  	int ret =3D 0;
>=20
> +	if (!is_header_feature(feature)) {
> +		base =3D devm_platform_ioremap_resource(pdev,
> +						      feature->resource_index);
> +		if (IS_ERR(base)) {
> +			dev_err(&pdev->dev,
> +				"ioremap failed for feature 0x%x!\n",
> +				feature->id);
> +			return PTR_ERR(base);
> +		}
> +
> +		feature->ioaddr =3D base;
> +	}
> +
>  	if (drv->ops->init) {
>  		ret =3D drv->ops->init(pdev, feature);
>  		if (ret)
> @@ -427,7 +443,9 @@ EXPORT_SYMBOL_GPL(dfl_fpga_dev_ops_unregister);
>   * @irq_table: Linux IRQ numbers for all irqs, indexed by local irq inde=
x of
>   *	       this device.
>   * @feature_dev: current feature device.
> - * @ioaddr: header register region address of feature device in enumerat=
ion.
> + * @ioaddr: header register region address of current FIU in enumeration=
.
> + * @start: register resource start of current FIU.
> + * @len: max register resource length of current FIU.
>   * @sub_features: a sub features linked list for feature device in
> enumeration.
>   * @feature_num: number of sub features for feature device in
> enumeration.
>   */
> @@ -439,6 +457,8 @@ struct build_feature_devs_info {
>=20
>  	struct platform_device *feature_dev;
>  	void __iomem *ioaddr;
> +	resource_size_t start;
> +	resource_size_t len;
>  	struct list_head sub_features;
>  	int feature_num;
>  };
> @@ -484,10 +504,7 @@ static int build_info_commit_dev(struct
> build_feature_devs_info *binfo)
>  	struct dfl_feature_platform_data *pdata;
>  	struct dfl_feature_info *finfo, *p;
>  	enum dfl_id_type type;
> -	int ret, index =3D 0;
> -
> -	if (!fdev)
> -		return 0;
> +	int ret, index =3D 0, res_idx =3D 0;
>=20
>  	type =3D feature_dev_id_type(fdev);
>  	if (WARN_ON_ONCE(type >=3D DFL_ID_MAX))
> @@ -530,16 +547,30 @@ static int build_info_commit_dev(struct
> build_feature_devs_info *binfo)
>=20
>  	/* fill features and resource information for feature dev */
>  	list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
> -		struct dfl_feature *feature =3D &pdata->features[index];
> +		struct dfl_feature *feature =3D &pdata->features[index++];
>  		struct dfl_feature_irq_ctx *ctx;
>  		unsigned int i;
>=20
>  		/* save resource information for each feature */
>  		feature->dev =3D fdev;
>  		feature->id =3D finfo->fid;
> -		feature->resource_index =3D index;
> -		feature->ioaddr =3D finfo->ioaddr;
> -		fdev->resource[index++] =3D finfo->mmio_res;
> +
> +		/*
> +		 * map header resource for dfl bus device. Don't add header
> +		 * resource to feature devices, or the resource tree will be
> +		 * disordered and cause warning on resource release
> +		 */
> +		if (is_header_feature(feature)) {
> +			feature->resource_index =3D -1;
> +			feature->ioaddr =3D
> +				devm_ioremap_resource(binfo->dev,
> +						      &finfo->mmio_res);
> +			if (IS_ERR(feature->ioaddr))
> +				return PTR_ERR(feature->ioaddr);
> +		} else {
> +			feature->resource_index =3D res_idx;
> +			fdev->resource[res_idx++] =3D finfo->mmio_res;
> +		}
>=20
>  		if (finfo->nr_irqs) {
>  			ctx =3D devm_kcalloc(binfo->dev, finfo->nr_irqs,
> @@ -582,19 +613,13 @@ static int build_info_commit_dev(struct
> build_feature_devs_info *binfo)
>=20
>  static int
>  build_info_create_dev(struct build_feature_devs_info *binfo,
> -		      enum dfl_id_type type, void __iomem *ioaddr)
> +		      enum dfl_id_type type)
>  {
>  	struct platform_device *fdev;
> -	int ret;
>=20
>  	if (type >=3D DFL_ID_MAX)
>  		return -EINVAL;
>=20
> -	/* we will create a new device, commit current device first */
> -	ret =3D build_info_commit_dev(binfo);
> -	if (ret)
> -		return ret;
> -
>  	/*
>  	 * we use -ENODEV as the initialization indicator which indicates
>  	 * whether the id need to be reclaimed
> @@ -605,7 +630,7 @@ build_info_create_dev(struct
> build_feature_devs_info *binfo,
>=20
>  	binfo->feature_dev =3D fdev;
>  	binfo->feature_num =3D 0;
> -	binfo->ioaddr =3D ioaddr;
> +
>  	INIT_LIST_HEAD(&binfo->sub_features);
>=20
>  	fdev->id =3D dfl_id_alloc(type, &fdev->dev);
> @@ -747,18 +772,17 @@ static int parse_feature_irqs(struct
> build_feature_devs_info *binfo,
>   */
>  static int
>  create_feature_instance(struct build_feature_devs_info *binfo,
> -			struct dfl_fpga_enum_dfl *dfl, resource_size_t ofst,
> -			resource_size_t size, u16 fid)
> +			resource_size_t ofst, resource_size_t size, u16 fid)
>  {
>  	unsigned int irq_base, nr_irqs;
>  	struct dfl_feature_info *finfo;
>  	int ret;
>=20
>  	/* read feature size and id if inputs are invalid */
> -	size =3D size ? size : feature_size(dfl->ioaddr + ofst);
> -	fid =3D fid ? fid : feature_id(dfl->ioaddr + ofst);
> +	size =3D size ? size : feature_size(binfo->ioaddr + ofst);
> +	fid =3D fid ? fid : feature_id(binfo->ioaddr + ofst);
>=20
> -	if (dfl->len - ofst < size)
> +	if (binfo->len - ofst < size)
>  		return -EINVAL;
>=20
>  	ret =3D parse_feature_irqs(binfo, ofst, fid, &irq_base, &nr_irqs);
> @@ -770,12 +794,11 @@ create_feature_instance(struct
> build_feature_devs_info *binfo,
>  		return -ENOMEM;
>=20
>  	finfo->fid =3D fid;
> -	finfo->mmio_res.start =3D dfl->start + ofst;
> +	finfo->mmio_res.start =3D binfo->start + ofst;
>  	finfo->mmio_res.end =3D finfo->mmio_res.start + size - 1;
>  	finfo->mmio_res.flags =3D IORESOURCE_MEM;
>  	finfo->irq_base =3D irq_base;
>  	finfo->nr_irqs =3D nr_irqs;
> -	finfo->ioaddr =3D dfl->ioaddr + ofst;
>=20
>  	list_add_tail(&finfo->node, &binfo->sub_features);
>  	binfo->feature_num++;
> @@ -784,7 +807,6 @@ create_feature_instance(struct
> build_feature_devs_info *binfo,
>  }
>=20
>  static int parse_feature_port_afu(struct build_feature_devs_info *binfo,
> -				  struct dfl_fpga_enum_dfl *dfl,
>  				  resource_size_t ofst)
>  {
>  	u64 v =3D readq(binfo->ioaddr + PORT_HDR_CAP);
> @@ -792,21 +814,22 @@ static int parse_feature_port_afu(struct
> build_feature_devs_info *binfo,
>=20
>  	WARN_ON(!size);
>=20
> -	return create_feature_instance(binfo, dfl, ofst, size,
> FEATURE_ID_AFU);
> +	return create_feature_instance(binfo, ofst, size, FEATURE_ID_AFU);
>  }
>=20
> +#define is_feature_dev_detected(binfo) (!!(binfo)->feature_dev)
> +
>  static int parse_feature_afu(struct build_feature_devs_info *binfo,
> -			     struct dfl_fpga_enum_dfl *dfl,
>  			     resource_size_t ofst)
>  {
> -	if (!binfo->feature_dev) {
> +	if (!is_feature_dev_detected(binfo)) {
>  		dev_err(binfo->dev, "this AFU does not belong to any
> FIU.\n");
>  		return -EINVAL;
>  	}
>=20
>  	switch (feature_dev_id_type(binfo->feature_dev)) {
>  	case PORT_ID:
> -		return parse_feature_port_afu(binfo, dfl, ofst);
> +		return parse_feature_port_afu(binfo, ofst);
>  	default:
>  		dev_info(binfo->dev, "AFU belonging to FIU %s is not
> supported yet.\n",
>  			 binfo->feature_dev->name);
> @@ -815,8 +838,40 @@ static int parse_feature_afu(struct
> build_feature_devs_info *binfo,
>  	return 0;
>  }
>=20
> +static int dfl_binfo_prepare(struct build_feature_devs_info *binfo,
> +			     resource_size_t start, resource_size_t len)
> +{
> +	struct device *dev =3D binfo->dev;
> +	void __iomem *ioaddr;
> +
> +	if (!devm_request_mem_region(dev, start, len, dev_name(dev))) {
> +		dev_err(dev, "request region fail, start:%pa, len:%pa\n",
> +			&start, &len);
> +		return -EBUSY;
> +	}
> +
> +	ioaddr =3D devm_ioremap(dev, start, len);
> +	if (!ioaddr) {
> +		dev_err(dev, "ioremap region fail, start:%pa, len:%pa\n",
> +			&start, &len);
> +		devm_release_mem_region(dev, start, len);

as it's devm_request_mem_region, do we still need to release it here?

> +		return -ENOMEM;
> +	}
> +
> +	binfo->start =3D start;
> +	binfo->len =3D len;
> +	binfo->ioaddr =3D ioaddr;
> +
> +	return 0;
> +}
> +
> +static void dfl_binfo_complete(struct build_feature_devs_info *binfo)
> +{
> +	devm_iounmap(binfo->dev, binfo->ioaddr);
> +	devm_release_mem_region(binfo->dev, binfo->start, binfo->len);
> +}
> +
>  static int parse_feature_fiu(struct build_feature_devs_info *binfo,
> -			     struct dfl_fpga_enum_dfl *dfl,
>  			     resource_size_t ofst)
>  {
>  	int ret =3D 0;
> @@ -824,27 +879,39 @@ static int parse_feature_fiu(struct
> build_feature_devs_info *binfo,
>  	u16 id;
>  	u64 v;
>=20
> -	v =3D readq(dfl->ioaddr + ofst + DFH);
> +	if (is_feature_dev_detected(binfo)) {
> +		dfl_binfo_complete(binfo);
> +
> +		ret =3D build_info_commit_dev(binfo);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D dfl_binfo_prepare(binfo, binfo->start + ofst,
> +					binfo->len - ofst);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	v =3D readq(binfo->ioaddr + DFH);
>  	id =3D FIELD_GET(DFH_ID, v);
>=20
>  	/* create platform device for dfl feature dev */
> -	ret =3D build_info_create_dev(binfo, dfh_id_to_type(id),
> -				    dfl->ioaddr + ofst);
> +	ret =3D build_info_create_dev(binfo, dfh_id_to_type(id));
>  	if (ret)
>  		return ret;
>=20
> -	ret =3D create_feature_instance(binfo, dfl, ofst, 0, 0);
> +	ret =3D create_feature_instance(binfo, 0, 0, 0);
>  	if (ret)
>  		return ret;
>  	/*
>  	 * find and parse FIU's child AFU via its NEXT_AFU register.
>  	 * please note that only Port has valid NEXT_AFU pointer per spec.
>  	 */
> -	v =3D readq(dfl->ioaddr + ofst + NEXT_AFU);
> +	v =3D readq(binfo->ioaddr + NEXT_AFU);
>=20
>  	offset =3D FIELD_GET(NEXT_AFU_NEXT_DFH_OFST, v);
>  	if (offset)
> -		return parse_feature_afu(binfo, dfl, ofst + offset);
> +		return parse_feature_afu(binfo, offset);
>=20
>  	dev_dbg(binfo->dev, "No AFUs detected on FIU %d\n", id);
>=20
> @@ -852,16 +919,15 @@ static int parse_feature_fiu(struct
> build_feature_devs_info *binfo,
>  }
>=20
>  static int parse_feature_private(struct build_feature_devs_info *binfo,
> -				 struct dfl_fpga_enum_dfl *dfl,
>  				 resource_size_t ofst)
>  {
> -	if (!binfo->feature_dev) {
> +	if (!is_feature_dev_detected(binfo)) {
>  		dev_err(binfo->dev, "the private feature 0x%x does not
> belong to any AFU.\n",
> -			feature_id(dfl->ioaddr + ofst));
> +			feature_id(binfo->ioaddr + ofst));
>  		return -EINVAL;
>  	}
>=20
> -	return create_feature_instance(binfo, dfl, ofst, 0, 0);
> +	return create_feature_instance(binfo, ofst, 0, 0);
>  }
>=20
>  /**
> @@ -869,24 +935,24 @@ static int parse_feature_private(struct
> build_feature_devs_info *binfo,
>   *
>   * @binfo: build feature devices information.
>   * @dfl: device feature list to parse

Remove this line.

Other place looks good to me.

Thanks
Hao

> - * @ofst: offset to feature header on this device feature list
> + * @ofst: offset to current FIU header
>   */
>  static int parse_feature(struct build_feature_devs_info *binfo,
> -			 struct dfl_fpga_enum_dfl *dfl, resource_size_t ofst)
> +			 resource_size_t ofst)
>  {
>  	u64 v;
>  	u32 type;
>=20
> -	v =3D readq(dfl->ioaddr + ofst + DFH);
> +	v =3D readq(binfo->ioaddr + ofst + DFH);
>  	type =3D FIELD_GET(DFH_TYPE, v);
>=20
>  	switch (type) {
>  	case DFH_TYPE_AFU:
> -		return parse_feature_afu(binfo, dfl, ofst);
> +		return parse_feature_afu(binfo, ofst);
>  	case DFH_TYPE_PRIVATE:
> -		return parse_feature_private(binfo, dfl, ofst);
> +		return parse_feature_private(binfo, ofst);
>  	case DFH_TYPE_FIU:
> -		return parse_feature_fiu(binfo, dfl, ofst);
> +		return parse_feature_fiu(binfo, ofst);
>  	default:
>  		dev_info(binfo->dev,
>  			 "Feature Type %x is not supported.\n", type);
> @@ -896,14 +962,17 @@ static int parse_feature(struct
> build_feature_devs_info *binfo,
>  }
>=20
>  static int parse_feature_list(struct build_feature_devs_info *binfo,
> -			      struct dfl_fpga_enum_dfl *dfl)
> +			      resource_size_t start, resource_size_t len)
>  {
> -	void __iomem *start =3D dfl->ioaddr;
> -	void __iomem *end =3D dfl->ioaddr + dfl->len;
> +	resource_size_t end =3D start + len;
>  	int ret =3D 0;
>  	u32 ofst =3D 0;
>  	u64 v;
>=20
> +	ret =3D dfl_binfo_prepare(binfo, start, len);
> +	if (ret)
> +		return ret;
> +
>  	/* walk through the device feature list via DFH's next DFH pointer. */
>  	for (; start < end; start +=3D ofst) {
>  		if (end - start < DFH_SIZE) {
> @@ -911,11 +980,11 @@ static int parse_feature_list(struct
> build_feature_devs_info *binfo,
>  			return -EINVAL;
>  		}
>=20
> -		ret =3D parse_feature(binfo, dfl, start - dfl->ioaddr);
> +		ret =3D parse_feature(binfo, start - binfo->start);
>  		if (ret)
>  			return ret;
>=20
> -		v =3D readq(start + DFH);
> +		v =3D readq(binfo->ioaddr + start - binfo->start + DFH);
>  		ofst =3D FIELD_GET(DFH_NEXT_HDR_OFST, v);
>=20
>  		/* stop parsing if EOL(End of List) is set or offset is 0 */
> @@ -924,7 +993,12 @@ static int parse_feature_list(struct
> build_feature_devs_info *binfo,
>  	}
>=20
>  	/* commit current feature device when reach the end of list */
> -	return build_info_commit_dev(binfo);
> +	dfl_binfo_complete(binfo);
> +
> +	if (is_feature_dev_detected(binfo))
> +		ret =3D build_info_commit_dev(binfo);
> +
> +	return ret;
>  }
>=20
>  struct dfl_fpga_enum_info *dfl_fpga_enum_info_alloc(struct device *dev)
> @@ -977,7 +1051,6 @@ EXPORT_SYMBOL_GPL(dfl_fpga_enum_info_free);
>   * @info: ptr to dfl_fpga_enum_info
>   * @start: mmio resource address of the device feature list.
>   * @len: mmio resource length of the device feature list.
> - * @ioaddr: mapped mmio resource address of the device feature list.
>   *
>   * One FPGA device may have one or more Device Feature Lists (DFLs), use
> this
>   * function to add information of each DFL to common data structure for
> next
> @@ -986,8 +1059,7 @@ EXPORT_SYMBOL_GPL(dfl_fpga_enum_info_free);
>   * Return: 0 on success, negative error code otherwise.
>   */
>  int dfl_fpga_enum_info_add_dfl(struct dfl_fpga_enum_info *info,
> -			       resource_size_t start, resource_size_t len,
> -			       void __iomem *ioaddr)
> +			       resource_size_t start, resource_size_t len)
>  {
>  	struct dfl_fpga_enum_dfl *dfl;
>=20
> @@ -997,7 +1069,6 @@ int dfl_fpga_enum_info_add_dfl(struct
> dfl_fpga_enum_info *info,
>=20
>  	dfl->start =3D start;
>  	dfl->len =3D len;
> -	dfl->ioaddr =3D ioaddr;
>=20
>  	list_add_tail(&dfl->node, &info->dfls);
>=20
> @@ -1120,7 +1191,7 @@ dfl_fpga_feature_devs_enumerate(struct
> dfl_fpga_enum_info *info)
>  	 * Lists.
>  	 */
>  	list_for_each_entry(dfl, &info->dfls, node) {
> -		ret =3D parse_feature_list(binfo, dfl);
> +		ret =3D parse_feature_list(binfo, dfl->start, dfl->len);
>  		if (ret) {
>  			remove_feature_devs(cdev);
>  			build_info_free(binfo);
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index bc61942..5973769 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -441,22 +441,17 @@ struct dfl_fpga_enum_info {
>   *
>   * @start: base address of this device feature list.
>   * @len: size of this device feature list.
> - * @ioaddr: mapped base address of this device feature list.
>   * @node: node in list of device feature lists.
>   */
>  struct dfl_fpga_enum_dfl {
>  	resource_size_t start;
>  	resource_size_t len;
> -
> -	void __iomem *ioaddr;
> -
>  	struct list_head node;
>  };
>=20
>  struct dfl_fpga_enum_info *dfl_fpga_enum_info_alloc(struct device *dev);
>  int dfl_fpga_enum_info_add_dfl(struct dfl_fpga_enum_info *info,
> -			       resource_size_t start, resource_size_t len,
> -			       void __iomem *ioaddr);
> +			       resource_size_t start, resource_size_t len);
>  int dfl_fpga_enum_info_add_irq(struct dfl_fpga_enum_info *info,
>  			       unsigned int nr_irqs, int *irq_table);
>  void dfl_fpga_enum_info_free(struct dfl_fpga_enum_info *info);
> --
> 2.7.4

