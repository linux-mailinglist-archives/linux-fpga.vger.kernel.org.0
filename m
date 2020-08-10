Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BE32401CF
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Aug 2020 07:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgHJF5B (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Aug 2020 01:57:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:11431 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgHJF5A (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 10 Aug 2020 01:57:00 -0400
IronPort-SDR: KqY1KxWZMvEfiaMg08wy2W6iSRDoC5fn5T5f1NyEe2WdUENHdyzaC7XHXfP82Smf5CtomhEl02
 XXAh6xErY7qQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9708"; a="217822973"
X-IronPort-AV: E=Sophos;i="5.75,456,1589266800"; 
   d="scan'208";a="217822973"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2020 22:56:54 -0700
IronPort-SDR: 7kXuhKaOGrkcZA2jBx6qu/I56Qt26tAtvkLlYO7gzjV5g5J9fZE89I9bd2ng94Yr9T/OoeXClS
 3W/4cuS8nLxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,456,1589266800"; 
   d="scan'208";a="317234135"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga004.fm.intel.com with ESMTP; 09 Aug 2020 22:56:54 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 9 Aug 2020 22:56:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 9 Aug 2020 22:56:53 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 9 Aug 2020 22:56:53 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 9 Aug 2020 22:56:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6w2yeRiDWsNTKRoyeZRyI/D3cw0kAoFrAyHqdpY56cSJa54TuiQguYm/v/KzebT9/rWD1aW2TbkV2UwS8+Ggd8rTWzXXaaxeIcwdoz3F71DjjN0tIXyS9uuU1ZcL1s9phwralVVziIeB6Tf4JSk8m53AeXu2QWk3DTSBW5NEzxyerzq9FjRdI1d0dYzE0QRR1agsTJUhRPaovQNd6nzXY8ciwCvPhBl7HnoDhh1bOrImJvjaBL8h2hWvKNGliQWtH95dqZKhsXgkxvkbDzHKPHzK8kyJNIlYWg12Cvm9kRZ6M1wMB5ZzzcQI4Go59Kcmnk5476M5n6XNulJYz75iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boG8nwbTENmwQu+8DxVRjX3/i1AYjvUhQtTNIcq0kTE=;
 b=HhyHN/UR0ycDFkyxJSMJir/UTncMBoee3q+gx/D1m3NTi9jSEy6a5J6Yli/fsuCuUYkwnQn1yYYkXXJGrVHlXnv0UmiIm92MR+clxfCF2xQ550XZoLWI/et0/rlLJGZDwAQudZi2RURwqcS3HlofkHXePXdmyAuUjxgGYJW29qoP/38R6TNVtQDHef9JlSVwcGOyi7dqChsuf/OcGXalaWEOk87BtvegrDZ/Rpi4tFGwsA6IwURus9X2s5TRP3MUTBCJyXyXN1NZc6jELEet8khYodpc3qSW9ySREZI82tc/VzFB/U0aK4fJ4qj3yE3euxdhy5S27TdjgHyhEOumjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boG8nwbTENmwQu+8DxVRjX3/i1AYjvUhQtTNIcq0kTE=;
 b=D8IK8vSqSuMZgau6PUIhgp8KJrwFdsF5P54RpaLyOyVniZKOJBjtUk27KxkdGISxHy1HoBleyiuwONThf/JS5JdeaRMc+Y9VFcTud9+A9p//zlX8VwARJzSb/IE3/rMRx282t8UyDQmdyyinADwXAmjKkvCuAK+8U9ue7GCO1b8=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3545.namprd11.prod.outlook.com (2603:10b6:5:141::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Mon, 10 Aug
 2020 05:56:44 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7823:516e:1ec4:a60d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7823:516e:1ec4:a60d%5]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 05:56:44 +0000
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
Subject: RE: [PATCH v4 2/4] fpga: dfl: map feature mmio resources in their own
 feature drivers
Thread-Topic: [PATCH v4 2/4] fpga: dfl: map feature mmio resources in their
 own feature drivers
Thread-Index: AQHWbsBEbYzrJw6Rv0alN+GwOJnyNKkw080Q
Date:   Mon, 10 Aug 2020 05:56:44 +0000
Message-ID: <DM6PR11MB381930E9699B086D37C27C4585440@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1597027273-25288-1-git-send-email-yilun.xu@intel.com>
 <1597027273-25288-3-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1597027273-25288-3-git-send-email-yilun.xu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27b47806-dd85-426a-a31b-08d83cf22944
x-ms-traffictypediagnostic: DM6PR11MB3545:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3545016F536E538945AC068F85440@DM6PR11MB3545.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MP9EL8K3ntB7e0ovgsQhKpDSPt6GvDOrHNa9XlRmdJInSzY4VfUFIJQvv1UcH/uWPaH0jaIqXgdkZXpfmd3KS8iI321z/zfVEAZFR8TeSXn+Ja6zgK2g7DARyeEb4FRGiZIoPwPLslm6etm3kqFqz3KqeNwbtFvzMUEfc/am9jnFDii0sPahpKvF0KoNnff2+3lh7xrNZeOZIxRp4ZXO6x7UMHnhF+9FGIyGImB4jurt7sVTVFtAza81wXKIYurA8+UcmnXmqynVrrqqf9Vckw32gZkwoXHoLB2mzUgvpC7dDbCTVBAll6T75BFAGI3Ic/nysn2fOU6L+UI0cYVyWzIFopzrDTWsHyoGI/yo5tYsAfafc8HORnKL9sXqmNp1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(5660300002)(55016002)(4326008)(9686003)(52536014)(8936002)(26005)(64756008)(66556008)(66446008)(66946007)(186003)(76116006)(33656002)(71200400001)(316002)(66476007)(30864003)(54906003)(110136005)(478600001)(86362001)(7696005)(2906002)(83380400001)(6506007)(53546011)(8676002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: FyS56pJjBil4regA19Mq0NHvkJm9cA/bMYwokGTejUIHfx3J09tK8qE3jFD8XulibZcR6+1AYP89t+9l9gpxbO7EqogoYBlzhl68adpBLiszWVMBsMeIqDSqtTSJjthA35Dg0SDxdgg2iEV3KOqR5M86I5UsxxlRgl3dLPxcKaAga42uk1FWMQywukSwBkSFlJftDKpQj6tOl62HxVJSpYBMOrMEYXHeeRwx8qfrC8aORukXnDmsfUSjSQxioQPRoYkcWdLR8H+SvKHvLObx78mJGDjbRKLU2oq9+1EgMMuwIxc7QglIwdPvb/UdrhpTjDRzOcz0y+d58Uuzh8iG27upHMJi/nVV8fTlyWreK6Ab14S8+dS35gdcNjhYZGlkOJcr+fur+yvmp6OZwFnWrWPvco37LZtxKhXAcshNhu3Ke3W2KhnjfS/k6lY4EPmtK5b/cdlLdhO6xs6vDIQDmjqwTsjZdF6o+aEJ+d7+kV44dp4NA6tiVGGm98Ktk8RpMajKSPIHOMTD8BC50fjYga5xvGZuC1QA0yUP7NU7p+xyPhcn+RDJLAVQPRZ4T4ffon8VXdMmvAHq3yYa5Ab3h2syn06fLXDhAMVx6Np367nzcYxjAaqQ+/ZNf/WhyWLKI1ByLL1wUNCkKV7PQX8sPg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b47806-dd85-426a-a31b-08d83cf22944
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 05:56:44.3882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WYLCNNKzI602Uw2avsDNcpnXhBtyhpBNDaGxLEVW5iMNLqfXNBqG85BP8v8ayXFeqV1WAAV7xoTp2wLzqH51GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3545
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> -----Original Message-----
> From: linux-fpga-owner@vger.kernel.org <linux-fpga-owner@vger.kernel.org>
> On Behalf Of Xu Yilun
> Sent: Monday, August 10, 2020 10:41 AM
> To: mdf@kernel.org; linux-fpga@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: trix@redhat.com; lgoncalv@redhat.com; Xu, Yilun <yilun.xu@intel.com>;
> Wu, Hao <hao.wu@intel.com>; Matthew Gerlach
> <matthew.gerlach@linux.intel.com>; Weight, Russell H
> <russell.h.weight@intel.com>
> Subject: [PATCH v4 2/4] fpga: dfl: map feature mmio resources in their ow=
n
> feature drivers
>=20
> This patch makes preparation for modularization of DFL sub feature
> drivers.
>=20
> Currently, if we need to support a new DFL sub feature, an entry should
> be added to fme/port_feature_drvs[] in dfl-fme/port-main.c. And we need

I think it's afu-main.c

> to re-compile the whole DFL modules. That make the DFL drivers hard to be
> extended.

And maybe we can drop this description or move it to cover letter as it's n=
ot
the problem this patch is going to resolve.

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
> Acked-by: Wu Hao <hao.wu@intel.com>
> ---
> v2: delete dfl_binfo_shift() cause no shift is possible for FIU parsing.
>     Only map bar0 for first phase enumeration in dfl-pci, we can find
>       all dfl mmio resource info in bar0.
>     Some minor fixes for comments from Hao & Tom.
> v3: no change
> v4: minor fixes for Hao's comments.
> ---
>  drivers/fpga/dfl-pci.c |  24 +++----
>  drivers/fpga/dfl.c     | 185 +++++++++++++++++++++++++++++++++----------=
----
> --
>  drivers/fpga/dfl.h     |   7 +-
>  3 files changed, 139 insertions(+), 77 deletions(-)
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
> index 18575d9..b5257d7 100644
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

I didn't get this description well, could you please explain it a little mo=
re
here?

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
> @@ -815,8 +838,39 @@ static int parse_feature_afu(struct
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
> @@ -824,27 +878,39 @@ static int parse_feature_fiu(struct
> build_feature_devs_info *binfo,
>  	u16 id;
>  	u64 v;
>=20
> -	v =3D readq(dfl->ioaddr + ofst + DFH);
> +	if (is_feature_dev_detected(binfo)) {
> +		dfl_binfo_complete(binfo);

Some functions are dfl_bind_xxxx but other are build_info_xxxx.
If possible, could we unify them using same format? E.g.
build_info_prepare/complete_xxx

Thanks
Hao

