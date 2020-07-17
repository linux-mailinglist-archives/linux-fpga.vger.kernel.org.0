Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB5F223935
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Jul 2020 12:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgGQK07 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 17 Jul 2020 06:26:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:20806 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgGQK06 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 17 Jul 2020 06:26:58 -0400
IronPort-SDR: 9i92luzpQabRQhqnd/hLj9L2vWE211YDC7u2dPs9g+jlimJK1isqoV7DWvlw1dnwEACFoXxYif
 zn0GbViIOqkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="147076086"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="147076086"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 03:26:41 -0700
IronPort-SDR: XwTosSGhEz6Mpuwnt1PL6lazH8R8d95L0uwUduURqKTOJnBvvjzgay4YZoW/9Z91TtApEQsYfj
 /bgziaD8aclQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="326810042"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga007.jf.intel.com with ESMTP; 17 Jul 2020 03:26:41 -0700
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Jul 2020 03:26:41 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx111.amr.corp.intel.com (10.18.116.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Jul 2020 03:26:40 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.51) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 17 Jul 2020 03:26:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9q3IohYsu62U/f+JgMLxEcW2gcFkH6LGDpjxbvIXkCf11M+A26S/gTsvyowJkatUuCJSLQhVVBUWJFr2+DJkDj2FGNyM4Xt2VATBIssHlOyQGTXb3igyZEdVvHCQN+2vuPGrGCenpRMkBazJ5/g7biSGKn1FWTD1Nec9JaBai+RUe1aNa5riNbqY398S2S35eCBRotihU7HzMCdKcZUYatlGyI+1ISvkbBcAG/T497tsDWILm4QArJ0paZYmayCA6MNTYtx/s0s8ZT8LmRh8gbqoW1VzE8dF3GwiBFqEyLDn1YJk9vAh+xNtHEMexX6UZvQuENNrLvClA+Gg+lvNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tyQmI+SGud6Sy0mWu7M6tXo13B4Fe6l2A1KY+Q3Qgs=;
 b=Pm3ejnt22WhcCqiLN7Ulnej3rdjovuFOh+CwJTBjcLdMgXclYjYiN0WCXF45dwfwCP0nA1dcwQ4t07VsZitFR7/Q1H84EAx1UZoJy/EXRLqZJBJtUZDoU8h+Id8Tun2nRAUGxAV+yU6nKxyMgBWY1MOC1Kyixwu12/bXVBJ58FHy7UFy5BSeRr1Wtbxn533Y8L69av74jlvY58zKYB0uP8Z77gAugFk21pAMa2rem+wT2GiRKlDKEq873WwinltGlATzKkWEw73aMzFGyQr4oSyrpVBrvK/XWe6DTIHmZqrffmdgR5Bcz4xb02PIC6vLDZeXoBWwNLDxOr47P9rIwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tyQmI+SGud6Sy0mWu7M6tXo13B4Fe6l2A1KY+Q3Qgs=;
 b=myzxN+mXAZoWLuV4OMieA0mkzyI8sdDz00+gLoQA9prA1Rg+OA/b8xZd8vI5sJ9G1gnj39OfLi3EJ1xvnqfaiIbsj2c6S/YxLKYZP9iUouyg69972uv+ihqK74JARnfxDMfMUoShT1Re39pE3o9VEp5YckIt1eUTdYkVyxDz3dg=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3179.namprd11.prod.outlook.com (2603:10b6:5:5e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 17 Jul
 2020 10:26:37 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a%4]) with mapi id 15.20.3174.026; Fri, 17 Jul 2020
 10:26:37 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: RE: [PATCH 2/2] fpga: dfl: create a dfl bus type to support DFL
 devices
Thread-Topic: [PATCH 2/2] fpga: dfl: create a dfl bus type to support DFL
 devices
Thread-Index: AQHWWmrPOwOoBf09SU2HXYt/SnOQpKkLijOA
Date:   Fri, 17 Jul 2020 10:26:37 +0000
Message-ID: <DM6PR11MB38195AA712F8089090695CE5857C0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1594791498-14495-1-git-send-email-yilun.xu@intel.com>
 <1594791498-14495-3-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1594791498-14495-3-git-send-email-yilun.xu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.218]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48f11f0f-cd49-4a14-57b4-08d82a3be30a
x-ms-traffictypediagnostic: DM6PR11MB3179:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3179EDB0D8D3F45F43563336857C0@DM6PR11MB3179.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:323;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FW0PH0uPCWebR0VJ3ug22fgEPaeF6sljPPFT46tYIjcVgINMDT/TRmg4/5SaNDegCbsa1zVlkVKX6BVyXJq9WOd8YdcANIG8xirRf4c9GNyXqKg9f6GKqN4zpZyJuo8OZ4wZ6wdovTUEqFqbKnAlRe6Q/CNrZmyLl0wsuX1yMS2riUT4APz3jsR+oUXQxiW3OSRw5T5mpDpVrbEyW0FUI83nrpgia9qZeSvC7Pfoc7uXWwcRt+dhgMca7u0CeVNFhJYzRT9jxbiWkkJGMcqMTW5zCPLsT4xiPNPI6x2My8/zB9UqhSP9yI096hq5F9rpEhu/98y/RG4Dhlen44Brxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(8936002)(54906003)(6506007)(55016002)(53546011)(7696005)(9686003)(30864003)(71200400001)(186003)(83380400001)(33656002)(478600001)(64756008)(66446008)(8676002)(76116006)(5660300002)(2906002)(66946007)(66556008)(66476007)(26005)(4326008)(316002)(110136005)(52536014)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 3hnVFdpwoZ+9T6GXxEH8/E/SVju3p5QLkJF0D8QQD5NmJfHDxWJ10AlISmwkGaFXmDkv3dQ3Jx6MPYQrj0zGcAUP8xAYycolD9gw9UA16UMTCygHNfowGtkroycfv0Dg0NcFwQqGis5ekpDVlUi8FDl+o+hNA/ykcfjvBFleePyhfRK4OPMBA+R3fIiDviBvzlPMMoYVaFHBjD4CZLsI68k0C9oIypxYsr2JEGkfBzm9zH31eeDrJQgWBKV63GO79vrN0ayJQrHoIql79XAxShvrdeB8hD0ETw9EY2+pJrsl4V5FgEges9MeFhFnejnvtQU89eaYKuo1H2R2eeU+aSZntE2hdGFY23EJV7dGQwQH6mwKn3hzNyyIGPhuXWkeUHT1UfVcv/6thOBjhFsletunLQmMTqnmCZAclb8i2N08bYIe+65oj6YXkephjUHastU4WZm6J//fy4R64zMzUUyMboBVAK6BpvOlDlFnpvK7kMKPOs30Rbb40J4dCkas
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f11f0f-cd49-4a14-57b4-08d82a3be30a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 10:26:37.2438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4HO4HFdr11dXOOzvtEfdb4x1sdoOacx4YM1Ev6RGAVSLw4MSi8GGImCOkoJmfOrAtD2+M7+17mkGs7GmThMP2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3179
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> -----Original Message-----
> From: Xu, Yilun <yilun.xu@intel.com>
> Sent: Wednesday, July 15, 2020 1:38 PM
> To: mdf@kernel.org; linux-fpga@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: trix@redhat.com; lgoncalv@redhat.com; Xu, Yilun <yilun.xu@intel.com>;
> Wu, Hao <hao.wu@intel.com>; Matthew Gerlach
> <matthew.gerlach@linux.intel.com>; Weight, Russell H
> <russell.h.weight@intel.com>
> Subject: [PATCH 2/2] fpga: dfl: create a dfl bus type to support DFL devi=
ces
>=20
> A new bus type "dfl" is introduced for private features which are not
> initialized by DFL feature drivers (dfl-fme & dfl-afu drivers). So these
> private features could be handled by separate driver modules.
>=20
> DFL framework will create DFL devices on enumeration.=20

Actually these DFL devices are created in AFU/FME driver initialization or =
real
core DFL code, is my understanding correct?

> DFL drivers could
> be registered on this bus to match these DFL devices. They are matched by
> dfl type & feature_id.
>=20
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-dfl |  15 ++
>  drivers/fpga/dfl.c                      | 248 ++++++++++++++++++++++++++=
++++--
>  drivers/fpga/dfl.h                      |  85 +++++++++++
>  3 files changed, 340 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-dfl
> b/Documentation/ABI/testing/sysfs-bus-dfl
> new file mode 100644
> index 0000000..cd00abc
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-dfl
> @@ -0,0 +1,15 @@
> +What:		/sys/bus/dfl/devices/.../type
> +Date:		March 2020
> +KernelVersion:	5.7

I guess you need to update the date and target kernel version.

> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It returns type of DFL FIU of the device. Now DF=
L
> +		supports 2 FIU types, 0 for FME, 1 for PORT.
> +		Format: 0x%x

Or consider just print the string instead here?

> +
> +What:		/sys/bus/dfl/devices/.../feature_id
> +Date:		March 2020
> +KernelVersion:	5.7

Ditto.

> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It returns feature identifier local to its DFL F=
IU
> +		type.
> +		Format: 0x%llx
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 7dc6411..93f9d6d 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -30,12 +30,6 @@ static DEFINE_MUTEX(dfl_id_mutex);
>   * index to dfl_chardevs table. If no chardev support just set devt_type
>   * as one invalid index (DFL_FPGA_DEVT_MAX).
>   */
> -enum dfl_id_type {
> -	FME_ID,		/* fme id allocation and mapping */
> -	PORT_ID,	/* port id allocation and mapping */
> -	DFL_ID_MAX,
> -};
> -
>  enum dfl_fpga_devt_type {
>  	DFL_FPGA_DEVT_FME,
>  	DFL_FPGA_DEVT_PORT,
> @@ -255,6 +249,228 @@ static bool is_header_feature(struct dfl_feature
> *feature)
>  	return feature->id =3D=3D FEATURE_ID_FIU_HEADER;
>  }
>=20
> +static const struct dfl_device_id *
> +dfl_match_one_device(const struct dfl_device_id *id,
> +		     struct dfl_device *dfl_dev)

Why start a new line here, it's just 80 char here. : )
BTW: you can use ddev instead of dfl_dev here for a shorter name.

> +{
> +	if (id->type =3D=3D dfl_dev->type &&
> +	    id->feature_id =3D=3D dfl_dev->feature_id)
> +		return id;
> +
> +	return NULL;
> +}
> +
> +static int dfl_bus_match(struct device *dev, struct device_driver *drv)
> +{
> +	struct dfl_device *dfl_dev =3D to_dfl_dev(dev);
> +	struct dfl_driver *dfl_drv =3D to_dfl_drv(drv);
> +	const struct dfl_device_id *id_entry =3D dfl_drv->id_table;
> +
> +	while (id_entry->feature_id) {
> +		if (dfl_match_one_device(id_entry, dfl_dev)) {
> +			dfl_dev->id_entry =3D id_entry;
> +			return 1;
> +		}
> +		id_entry++;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dfl_bus_probe(struct device *dev)
> +{
> +	struct dfl_device *dfl_dev =3D to_dfl_dev(dev);
> +	struct dfl_driver *dfl_drv =3D to_dfl_drv(dev->driver);
> +
> +	return dfl_drv->probe(dfl_dev);
> +}
> +
> +static int dfl_bus_remove(struct device *dev)
> +{
> +	struct dfl_device *dfl_dev =3D to_dfl_dev(dev);
> +	struct dfl_driver *dfl_drv =3D to_dfl_drv(dev->driver);
> +
> +	if (dfl_drv->remove)
> +		dfl_drv->remove(dfl_dev);
> +
> +	return 0;
> +}
> +
> +static int dfl_bus_uevent(struct device *dev, struct kobj_uevent_env *en=
v)
> +{
> +	struct dfl_device *dfl_dev =3D to_dfl_dev(dev);
> +
> +	if (add_uevent_var(env, "MODALIAS=3Ddfl:%08x:%016llx",
> +			   dfl_dev->type, dfl_dev->feature_id))

I see for pci bus, it's using v%08Xd%08X... should we consider adding one
"t" to indicate that value is for type? Will that be simpler to the users?

> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +/* show dfl info fields */
> +#define dfl_info_attr(field, format_string)				\
> +static ssize_t								\
> +field##_show(struct device *dev, struct device_attribute *attr,
> 	\
> +	     char *buf)							\
> +{									\
> +	struct dfl_device *dfl_dev =3D to_dfl_dev(dev);			\
> +									\
> +	return sprintf(buf, format_string, dfl_dev->field);		\
> +}									\
> +static DEVICE_ATTR_RO(field)
> +
> +dfl_info_attr(type, "0x%x\n");
> +dfl_info_attr(feature_id, "0x%llx\n");
> +
> +static struct attribute *dfl_dev_attrs[] =3D {
> +	&dev_attr_type.attr,
> +	&dev_attr_feature_id.attr,
> +	NULL,
> +};
> +
> +ATTRIBUTE_GROUPS(dfl_dev);
> +
> +static struct bus_type dfl_bus_type =3D {
> +	.name		=3D "dfl",
> +	.match		=3D dfl_bus_match,
> +	.probe		=3D dfl_bus_probe,
> +	.remove		=3D dfl_bus_remove,
> +	.uevent		=3D dfl_bus_uevent,
> +	.dev_groups	=3D dfl_dev_groups,
> +};
> +
> +static void release_dfl_dev(struct device *dev)
> +{
> +	struct dfl_device *dfl_dev =3D to_dfl_dev(dev);
> +
> +	release_resource(&dfl_dev->mmio_res);
> +	kfree(dfl_dev->irqs);
> +	kfree(dfl_dev);
> +}
> +
> +static struct dfl_device *
> +dfl_dev_add(struct dfl_feature_platform_data *pdata,
> +	    struct dfl_feature *feature)
> +{
> +	struct platform_device *pdev =3D pdata->dev;
> +	struct dfl_device *dfl_dev;
> +	int i, ret;
> +
> +	dfl_dev =3D kzalloc(sizeof(*dfl_dev), GFP_KERNEL);
> +	if (!dfl_dev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	dfl_dev->cdev =3D pdata->dfl_cdev;
> +
> +	dfl_dev->mmio_res.parent =3D &pdev->resource[feature-
> >resource_index];
> +	dfl_dev->mmio_res.flags =3D IORESOURCE_MEM;
> +	dfl_dev->mmio_res.start =3D
> +		pdev->resource[feature->resource_index].start;
> +	dfl_dev->mmio_res.end =3D pdev->resource[feature-
> >resource_index].end;
> +
> +	/* then add irq resource */
> +	if (feature->nr_irqs) {
> +		dfl_dev->irqs =3D kcalloc(feature->nr_irqs,
> +					sizeof(*dfl_dev->irqs), GFP_KERNEL);
> +		if (!dfl_dev->irqs) {
> +			ret =3D -ENOMEM;
> +			goto free_dfl_dev;
> +		}
> +
> +		for (i =3D 0; i < feature->nr_irqs; i++)
> +			dfl_dev->irqs[i] =3D feature->irq_ctx[i].irq;
> +
> +		dfl_dev->num_irqs =3D feature->nr_irqs;
> +	}
> +
> +	dfl_dev->type =3D feature_dev_id_type(pdev);
> +	dfl_dev->feature_id =3D (unsigned long long)feature->id;
> +
> +	dfl_dev->dev.parent  =3D &pdev->dev;
> +	dfl_dev->dev.bus     =3D &dfl_bus_type;
> +	dfl_dev->dev.release =3D release_dfl_dev;
> +	dev_set_name(&dfl_dev->dev, "%s.%d", dev_name(&pdev->dev),
> +		     feature->index);

Or it's better to have a generic name for the device on the bus.

> +
> +	dfl_dev->mmio_res.name =3D dev_name(&dfl_dev->dev);
> +	ret =3D insert_resource(dfl_dev->mmio_res.parent, &dfl_dev-
> >mmio_res);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s failed to claim resource: %pR\n",
> +			dev_name(&dfl_dev->dev), &dfl_dev->mmio_res);
> +		goto free_irqs;
> +	}
> +
> +	ret =3D device_register(&dfl_dev->dev);
> +	if (ret) {
> +		put_device(&dfl_dev->dev);
> +		return ERR_PTR(ret);
> +	}
> +
> +	dev_info(&pdev->dev, "add dfl_dev: %s\n",
> +		 dev_name(&dfl_dev->dev));
> +	return dfl_dev;
> +
> +free_irqs:
> +	kfree(dfl_dev->irqs);
> +free_dfl_dev:
> +	kfree(dfl_dev);
> +	return ERR_PTR(ret);
> +}
> +
> +static void dfl_devs_uinit(struct dfl_feature_platform_data *pdata)
> +{
> +	struct dfl_device *dfl_dev;
> +	struct dfl_feature *feature;
> +
> +	dfl_fpga_dev_for_each_feature(pdata, feature) {
> +		if (!feature->ioaddr && feature->priv) {
> +			dfl_dev =3D feature->priv;
> +			device_unregister(&dfl_dev->dev);
> +			feature->priv =3D NULL;
> +		}
> +	}
> +}
> +
> +static int dfl_devs_init(struct platform_device *pdev)
> +{
> +	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> >dev);
> +	struct dfl_feature *feature;
> +	struct dfl_device *dfl_dev;
> +
> +	dfl_fpga_dev_for_each_feature(pdata, feature) {
> +		if (feature->ioaddr || feature->priv)
> +			continue;
> +
> +		dfl_dev =3D dfl_dev_add(pdata, feature);
> +		if (IS_ERR(dfl_dev)) {
> +			dfl_devs_uinit(pdata);
> +			return PTR_ERR(dfl_dev);
> +		}
> +
> +		feature->priv =3D dfl_dev;

If=20

> +	}
> +
> +	return 0;
> +}
> +
> +int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *own=
er)
> +{
> +	if (!dfl_drv || !dfl_drv->probe || !dfl_drv->id_table)
> +		return -EINVAL;
> +
> +	dfl_drv->drv.owner =3D owner;
> +	dfl_drv->drv.bus =3D &dfl_bus_type;
> +
> +	return driver_register(&dfl_drv->drv);
> +}
> +EXPORT_SYMBOL(__dfl_driver_register);
> +
> +void dfl_driver_unregister(struct dfl_driver *dfl_drv)
> +{
> +	driver_unregister(&dfl_drv->drv);
> +}
> +EXPORT_SYMBOL(dfl_driver_unregister);
> +
>  /**
>   * dfl_fpga_dev_feature_uinit - uinit for sub features of dfl feature de=
vice
>   * @pdev: feature device.
> @@ -264,12 +480,15 @@ void dfl_fpga_dev_feature_uinit(struct
> platform_device *pdev)
>  	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> >dev);
>  	struct dfl_feature *feature;
>=20
> -	dfl_fpga_dev_for_each_feature(pdata, feature)
> +	dfl_devs_uinit(pdata);
> +
> +	dfl_fpga_dev_for_each_feature(pdata, feature) {
>  		if (feature->ops) {
>  			if (feature->ops->uinit)
>  				feature->ops->uinit(pdev, feature);
>  			feature->ops =3D NULL;
>  		}
> +	}
>  }
>  EXPORT_SYMBOL_GPL(dfl_fpga_dev_feature_uinit);
>=20
> @@ -348,6 +567,10 @@ int dfl_fpga_dev_feature_init(struct
> platform_device *pdev,
>  		drv++;
>  	}
>=20
> +	ret =3D dfl_devs_init(pdev);
> +	if (ret)
> +		goto exit;
> +
>  	return 0;
>  exit:
>  	dfl_fpga_dev_feature_uinit(pdev);
> @@ -553,6 +776,8 @@ static int build_info_commit_dev(struct
> build_feature_devs_info *binfo)
>  		struct dfl_feature_irq_ctx *ctx;
>  		unsigned int i;
>=20
> +		feature->index =3D index;
> +
>  		/* save resource information for each feature */
>  		feature->dev =3D fdev;
>  		feature->id =3D finfo->fid;
> @@ -1295,11 +1520,17 @@ static int __init dfl_fpga_init(void)
>  {
>  	int ret;
>=20
> +	ret =3D bus_register(&dfl_bus_type);
> +	if (ret)
> +		return ret;
> +
>  	dfl_ids_init();
>=20
>  	ret =3D dfl_chardev_init();
> -	if (ret)
> +	if (ret) {
>  		dfl_ids_destroy();
> +		bus_unregister(&dfl_bus_type);
> +	}
>=20
>  	return ret;
>  }
> @@ -1637,6 +1868,7 @@ static void __exit dfl_fpga_exit(void)
>  {
>  	dfl_chardev_uinit();
>  	dfl_ids_destroy();
> +	bus_unregister(&dfl_bus_type);
>  }
>=20
>  module_init(dfl_fpga_init);
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index f605c28..d00aa1c 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -229,6 +229,10 @@ struct dfl_feature_irq_ctx {
>   *
>   * @dev: ptr to pdev of the feature device which has the sub feature.
>   * @id: sub feature id.
> + * @index: unique identifier for an sub feature within the feature devic=
e.
> + *	   It is possible that multiply sub features with same feature id are
> + *	   listed in one feature device. So an incremental index (start from =
0)
> + *	   is needed to identify each sub feature.
>   * @resource_index: each sub feature has one mmio resource for its
> registers.
>   *		    this index is used to find its mmio resource from the
>   *		    feature dev (platform device)'s reources.
> @@ -241,6 +245,7 @@ struct dfl_feature_irq_ctx {
>  struct dfl_feature {
>  	struct platform_device *dev;
>  	u64 id;
> +	int index;
>  	int resource_index;
>  	void __iomem *ioaddr;
>  	struct dfl_feature_irq_ctx *irq_ctx;
> @@ -515,4 +520,84 @@ long dfl_feature_ioctl_set_irq(struct
> platform_device *pdev,
>  			       struct dfl_feature *feature,
>  			       unsigned long arg);
>=20
> +/**
> + * enum dfl_id_type - define the DFL FIU types
> + */
> +enum dfl_id_type {
> +	FME_ID,
> +	PORT_ID,
> +	DFL_ID_MAX,
> +};
> +
> +/**
> + * struct dfl_device_id -  dfl device identifier
> + * @type: Type of DFL FIU of the device. See enum dfl_id_type.
> + * @feature_id: 64 bits feature identifier local to its DFL FIU type.
> + * @driver_data: Driver specific data
> + */
> +struct dfl_device_id {
> +	unsigned int type;
> +	unsigned long long feature_id;
> +	unsigned long driver_data;

Seems not used yet for driver_data, or can be in later patch with real user=
s.

> +};
> +
> +/**
> + * struct dfl_device - represent an dfl device on dfl bus
> + *
> + * @dev: Generic device interface.
> + * @type: Type of DFL FIU of the device. See enum dfl_id_type.
> + * @feature_id: 64 bits feature identifier local to its DFL FIU type.
> + * @mmio_res: MMIO resource of this dfl device.
> + * @irqs: List of Linux IRQ numbers of this dfl device.
> + * @num_irqs: number of IRQs supported by this dfl device.
> + * @cdev: pointer to DFL FPGA container device this dfl device belongs t=
o.
> + * @id_entry: matched id entry in dfl driver's id table.
> + */
> +struct dfl_device {
> +	struct device dev;
> +	unsigned int type;
> +	unsigned long long feature_id;
> +	struct resource mmio_res;
> +	int *irqs;
> +	unsigned int num_irqs;
> +	struct dfl_fpga_cdev *cdev;
> +	const struct dfl_device_id *id_entry;
> +};
> +
> +/**
> + * struct dfl_driver - represent an dfl device driver
> + *
> + * @drv: Driver model structure.
> + * @id_table: Pointer to table of device IDs the driver is interested in=
.
> + * @probe: Callback for device binding.
> + * @remove: Callback for device unbinding.
> + */
> +struct dfl_driver {
> +	struct device_driver drv;
> +	const struct dfl_device_id *id_table;
> +
> +	int (*probe)(struct dfl_device *dfl_dev);
> +	int (*remove)(struct dfl_device *dfl_dev);
> +};
> +
> +#define to_dfl_dev(d) container_of(d, struct dfl_device, dev)
> +#define to_dfl_drv(d) container_of(d, struct dfl_driver, drv)
> +
> +/*
> + * use a macro to avoid include chaining to get THIS_MODULE
> + */
> +#define dfl_driver_register(drv) \
> +	__dfl_driver_register(drv, THIS_MODULE)
> +int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *own=
er);
> +void dfl_driver_unregister(struct dfl_driver *dfl_drv);
> +
> +/* module_dfl_driver() - Helper macro for drivers that don't do

/*
 * module_dfl_driver()

> + * anything special in module init/exit.  This eliminates a lot of
> + * boilerplate.  Each module may only use this macro once, and
> + * calling it replaces module_init() and module_exit()
> + */
> +#define module_dfl_driver(__dfl_driver) \
> +	module_driver(__dfl_driver, dfl_driver_register, \
> +		      dfl_driver_unregister)
> +
>  #endif /* __FPGA_DFL_H */

BTW: maybe it's better to have one patch to add a driver using this bus as =
an example?

Thanks
Hao

> --
> 2.7.4

