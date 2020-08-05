Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E2723CFF8
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Aug 2020 21:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgHET1f (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Aug 2020 15:27:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:35492 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728525AbgHERMk (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 5 Aug 2020 13:12:40 -0400
IronPort-SDR: qk6RFBJR3VBksg8R05NHj6wK8os+uJQHFMcqbh/5HFcIqS6OGz32Vhzt31cXQ8feeq8BYnkzfs
 /TplBJkpssFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="170585937"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="170585937"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 03:29:17 -0700
IronPort-SDR: kRrNGnFUZeZ18hS3fQTZCAzEmI2Jxe4FxH1+Z+Kcz2d/nGTdhDpEJWfrgEVBeaODy5xKdNNh3y
 zeSDa7uNeT8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="324979123"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 05 Aug 2020 03:29:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 5 Aug 2020 03:29:16 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 5 Aug 2020 03:29:15 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 5 Aug 2020 03:29:15 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.55) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 5 Aug 2020 03:29:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/fYlA8ioml1j2f+zPzJYAVI6sl5ny4zssUC4L6/SYimHbo+u/UVHvuwDtz7shaxx1KUoViLfUo59BeEz/fqIlgP0ZNcv3TeXEWFpe2R7szO2nx1cRGglc89WBCUmlFLyyoppMf9QkCN4AxIARx5/Yxlzc2WC7oQLRKsWWeJLPaV8T+WpX6KG7vTF3m+2Fx1+xHqTjcv39PeSi59QJ/TgO13rjTkmf733bDoPMBYHqUbf6ufe46rgShBDOuheHBfx+Wyu8e6nSt6G9ZD5U5MfrhM0LvnMXhepG2CNNOcZyinp96E54aF+APrZBfdoFH9LO5Sx2iIge93M6Nj3Omw+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqLNdJ0tvBTu6WtqgVWQd8l1aE0KEmHP9Q6MQjzdHkY=;
 b=VkMPg3O5myrOoqDJ8jy+Vy5LuKwLsbVjy6YOlXsS2wEhRV2YW5OkJWVTuYauZxMG84mrkwh/RkEuLC4ZMGFDRY+anTPlh7ERnr8uFCuxSXLH3eFyfRtdcz2XBd5zAKW8//yNCYqVmLpFHkMX8G0OG58sCQ428ceP1LOaVZWh6RhQxIcocsP32WNf0IQne1X/XnJNPDBu0/YZQOqlUZoCTo+LGDsizFk8slNbkvtI1NlwrJ21E7ZwZN3dIzGWxfujayrHyBJFLKZsxXaE+Pkkr1f6quyEUoB7FTbag6EIfx0ebiauN4fSuMWUlvv2Uc4BKZZ/0nEGeBI3+pu0/XG9KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqLNdJ0tvBTu6WtqgVWQd8l1aE0KEmHP9Q6MQjzdHkY=;
 b=uzfvQ7SMpmtg7SRxPSAhgh6rfzXwratozu3mVrObIh1YI1xxQ2nY5tugiVhg4rbqRAf8VSfA0EFvFpGNq0VBaZT7kScGyo4h+0BhOcjMkJeGWhdRGp1kfxndUMaHoE6qtTLxZ1MFe3bVXiKr9uhwyBAAr21YGb76fIXSa2HvYic=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM5PR11MB1947.namprd11.prod.outlook.com (2603:10b6:3:110::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Wed, 5 Aug
 2020 10:29:11 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a%4]) with mapi id 15.20.3239.022; Wed, 5 Aug 2020
 10:29:11 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: RE: [PATCH v3 3/4] fpga: dfl: create a dfl bus type to support DFL
 devices
Thread-Topic: [PATCH v3 3/4] fpga: dfl: create a dfl bus type to support DFL
 devices
Thread-Index: AQHWai4sIUNwsVZ/O0CmWJFTiJacfqkpPTvA
Date:   Wed, 5 Aug 2020 10:29:11 +0000
Message-ID: <DM6PR11MB38194B629A3DC70FC0E8A010854B0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1596524715-18038-1-git-send-email-yilun.xu@intel.com>
 <1596524715-18038-4-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1596524715-18038-4-git-send-email-yilun.xu@intel.com>
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
x-ms-office365-filtering-correlation-id: b23e2c80-5bd7-49b8-4139-08d8392a64ae
x-ms-traffictypediagnostic: DM5PR11MB1947:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB194791B6236C2DF23D194A56854B0@DM5PR11MB1947.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QZa2gV3+B6+LqsiUcfIpq5HqTuDTXZWORlzKXG8269oq0TRFU7TJT1DVu66oja21cc/s7Kq4D77SYvY3LWB2uT5RDXRCnjaD4pD/BHQSBMzFxApNioST5jHeqryR5Sd0VZevB77k2NdfwEf1PMXLJzkKhw5yXAT8UNkzsrgCldgA4jWrrWiTswMIimJItJIS3lm2CmfB2CpcOWYUsORuSQuZiRw2TA7UcC8oXUMG9eI//16+YHFsfOpePxoQtg+Fil+nLRdMW1Y2MFGYhV9yUQI1XPGZUwoiy3lzupp+yQO30kKQvWEsXVVdh+AFRIYOQ7A6V15dMo5ufeym9dP52g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(478600001)(8936002)(66556008)(66446008)(86362001)(76116006)(30864003)(83380400001)(66476007)(4326008)(2906002)(66946007)(5660300002)(64756008)(33656002)(8676002)(316002)(55016002)(26005)(52536014)(186003)(71200400001)(6506007)(7696005)(110136005)(9686003)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: chW4FBwkdym7B8Ul/gN/ogqRhsdZBC+pKCPFsMj5BOo6NdRb/9JzdKZ0cwOWyjpDSrgv1pLr/tqp/9ocMEvtRF7XUIBv+4QwoxqG2bDFnDqpH3dLdCujqUChzJJrVmsVyF3Vm45CBxKHILFfCKjjXyr6J/PtHUGLHBe2VzcTV/5HK13tFRh95IwtiI1xvvcIXHo2ydsnS7r6cIAFVkTFPEhMKm96exG5TWboEVZzSY6gYwrVW80d2NtvuEc0jdiVtiGOU3BSKjN+QvEUvjWVoymD03mvBZ7nQ854kfhz8k1f+zvTnFH9EHoPObyDEmR77+6RX0hj00Ct/eP72oAJDlDW0eMddHPCyFc5+N8CXA5FhaD9qEzN3PmM86I90Ct7+CbAuyvYv4lmWJO1j/OtaDEe2DJYPLnjTfpWejVmZbQvpVPvdYatXdfPRw7KzHFH6ecXyZq7bWQVTVAKU4/dVHnHhtjJNeHynwsTTfqbGMVGcBBwXkM4eobMadJAr2mMHhxXInLNoLSDS6+y5d3jE8F7tx2+lxmTrxvw6A9HZNhrH9n3Y6yubaCYVEzO72NX0wkmWhWlhkz3iRvfwRh8UhdQO/RAImK17ZgxitFQ9YVc9WJnILqExh6R0csMH3pWh08bRMqGu3GOmLs3fo0ayQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23e2c80-5bd7-49b8-4139-08d8392a64ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2020 10:29:11.1677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JLW57PRBRmRbvYP4HPwmKF+CjRS0Vv8Oe4kvotY3YlEAKTRgRdcbOljet5Q+An3M1imjb7e9BdX2UrRtrDFqDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1947
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v3 3/4] fpga: dfl: create a dfl bus type to support DFL d=
evices
>=20
> A new bus type "dfl" is introduced for private features which are not
> initialized by DFL feature drivers (dfl-fme & dfl-afu drivers). So these
> private features could be handled by separate driver modules.
>=20
> DFL feature drivers (dfl-fme, dfl-port) will create DFL devices on
> enumeration. DFL drivers could be registered on this bus to match these
> DFL devices. They are matched by dfl type & feature_id.
>=20
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
> v2: change the bus uevent format.
>     change the dfl device's sysfs name format.
>     refactor dfl_dev_add().
>     minor fixes for comments from Hao and Tom.
> v3: no change.
> ---
>  Documentation/ABI/testing/sysfs-bus-dfl |  15 ++
>  drivers/fpga/dfl.c                      | 254 ++++++++++++++++++++++++++=
+++++-
>  drivers/fpga/dfl.h                      |  84 +++++++++++
>  3 files changed, 345 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-dfl
> b/Documentation/ABI/testing/sysfs-bus-dfl
> new file mode 100644
> index 0000000..b1eea30
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-dfl
> @@ -0,0 +1,15 @@
> +What:		/sys/bus/dfl/devices/.../type

So it will be clear, that it's always dfl_dev.X/type here?

> +Date:		July 2020
> +KernelVersion:	5.9

Same as the other patches.

> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It returns type of DFL FIU of the device. Now DF=
L
> +		supports 2 FIU types, 0 for FME, 1 for PORT.
> +		Format: 0x%x
> +
> +What:		/sys/bus/dfl/devices/.../feature_id

Same?

> +Date:		July 2020
> +KernelVersion:	5.9

Ditto

> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It returns feature identifier local to its DFL F=
IU
> +		type.
> +		Format: 0x%x
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index c649239..978d182 100644
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
> @@ -250,6 +244,236 @@ int dfl_fpga_check_port_id(struct platform_device
> *pdev, void *pport_id)
>  }
>  EXPORT_SYMBOL_GPL(dfl_fpga_check_port_id);
>=20
> +static DEFINE_IDA(dfl_device_ida);
> +
> +static const struct dfl_device_id *
> +dfl_match_one_device(const struct dfl_device_id *id, struct dfl_device
> *ddev)
> +{
> +	if (id->type =3D=3D ddev->type && id->feature_id =3D=3D ddev->feature_i=
d)
> +		return id;
> +
> +	return NULL;
> +}
> +
> +static int dfl_bus_match(struct device *dev, struct device_driver *drv)
> +{
> +	struct dfl_device *ddev =3D to_dfl_dev(dev);
> +	struct dfl_driver *ddrv =3D to_dfl_drv(drv);
> +	const struct dfl_device_id *id_entry =3D ddrv->id_table;
> +
> +	if (id_entry) {
> +		while (id_entry->feature_id) {
> +			if (dfl_match_one_device(id_entry, ddev)) {
> +				ddev->id_entry =3D id_entry;
> +				return 1;
> +			}
> +			id_entry++;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int dfl_bus_probe(struct device *dev)
> +{
> +	struct dfl_device *ddev =3D to_dfl_dev(dev);
> +	struct dfl_driver *ddrv =3D to_dfl_drv(dev->driver);
> +
> +	return ddrv->probe(ddev);
> +}
> +
> +static int dfl_bus_remove(struct device *dev)
> +{
> +	struct dfl_device *ddev =3D to_dfl_dev(dev);
> +	struct dfl_driver *ddrv =3D to_dfl_drv(dev->driver);
> +
> +	if (ddrv->remove)
> +		ddrv->remove(ddev);
> +
> +	return 0;
> +}
> +
> +static int dfl_bus_uevent(struct device *dev, struct kobj_uevent_env *en=
v)
> +{
> +	struct dfl_device *ddev =3D to_dfl_dev(dev);
> +
> +	return add_uevent_var(env, "MODALIAS=3Ddfl:t%08Xf%04X",
> +			      ddev->type, ddev->feature_id);

Then we only print 12bit of feature_id will be enough?
should we make type shorter as well as feature id?
And do you think if we should add a new field for dfl version?

> +}
> +
> +/* show dfl info fields */
> +#define dfl_info_attr(field, format_string)				\
> +static ssize_t								\
> +field##_show(struct device *dev, struct device_attribute *attr,
> 	\
> +	     char *buf)							\
> +{									\
> +	struct dfl_device *ddev =3D to_dfl_dev(dev);			\
> +									\
> +	return sprintf(buf, format_string, ddev->field);		\
> +}									\
> +static DEVICE_ATTR_RO(field)
> +
> +dfl_info_attr(type, "0x%x\n");
> +dfl_info_attr(feature_id, "0x%x\n");
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
> +	struct dfl_device *ddev =3D to_dfl_dev(dev);
> +
> +	if (ddev->mmio_res.parent)
> +		release_resource(&ddev->mmio_res);
> +
> +	ida_simple_remove(&dfl_device_ida, ddev->id);
> +	kfree(ddev->irqs);
> +	kfree(ddev);
> +}
> +
> +static struct dfl_device *
> +dfl_dev_add(struct dfl_feature_platform_data *pdata,
> +	    struct dfl_feature *feature)
> +{
> +	struct platform_device *pdev =3D pdata->dev;
> +	struct resource *parent_res;
> +	struct dfl_device *ddev;
> +	int id, i, ret;
> +
> +	ddev =3D kzalloc(sizeof(*ddev), GFP_KERNEL);

If we only consider add dfl device during initialization of=20
FME/PORT device, then it should be able to use devm_xx version?

> +	if (!ddev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	id =3D ida_simple_get(&dfl_device_ida, 0, 0, GFP_KERNEL);
> +	if (id < 0) {
> +		dev_err(&pdev->dev, "unable to get id\n");
> +		kfree(ddev);
> +		return ERR_PTR(id);
> +	}
> +
> +	/* freeing resources by put_device() after device_initialize() */
> +	device_initialize(&ddev->dev);
> +	ddev->dev.parent =3D &pdev->dev;
> +	ddev->dev.bus =3D &dfl_bus_type;
> +	ddev->dev.release =3D release_dfl_dev;
> +	ddev->id =3D id;
> +	ret =3D dev_set_name(&ddev->dev, "dfl_dev.%d", id);
> +	if (ret)
> +		goto put_dev;
> +
> +	ddev->type =3D feature_dev_id_type(pdev);
> +	ddev->feature_id =3D feature->id;
> +	ddev->cdev =3D pdata->dfl_cdev;
> +
> +	/* add mmio resource */
> +	parent_res =3D &pdev->resource[feature->resource_index];
> +	ddev->mmio_res.flags =3D IORESOURCE_MEM;
> +	ddev->mmio_res.start =3D parent_res->start;
> +	ddev->mmio_res.end =3D parent_res->end;
> +	ddev->mmio_res.name =3D dev_name(&ddev->dev);
> +	ret =3D insert_resource(parent_res, &ddev->mmio_res);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s failed to claim resource: %pR\n",
> +			dev_name(&ddev->dev), &ddev->mmio_res);
> +		goto put_dev;
> +	}
> +
> +	/* then add irq resource */
> +	if (feature->nr_irqs) {
> +		ddev->irqs =3D kcalloc(feature->nr_irqs,
> +				     sizeof(*ddev->irqs), GFP_KERNEL);
> +		if (!ddev->irqs) {
> +			ret =3D -ENOMEM;
> +			goto put_dev;
> +		}
> +
> +		for (i =3D 0; i < feature->nr_irqs; i++)
> +			ddev->irqs[i] =3D feature->irq_ctx[i].irq;
> +
> +		ddev->num_irqs =3D feature->nr_irqs;

Do we need to consider using IORESOURCE_IRQ here as well?

> +	}
> +
> +	ret =3D device_add(&ddev->dev);
> +	if (ret)
> +		goto put_dev;
> +
> +	dev_info(&pdev->dev, "add dfl_dev: %s\n", dev_name(&ddev->dev));
> +	return ddev;
> +
> +put_dev:
> +	/* calls release_dfl_dev() which does the clean up  */
> +	put_device(&ddev->dev);
> +	return ERR_PTR(ret);
> +}
> +
> +static void dfl_devs_uinit(struct dfl_feature_platform_data *pdata)
> +{
> +	struct dfl_device *ddev;
> +	struct dfl_feature *feature;
> +
> +	dfl_fpga_dev_for_each_feature(pdata, feature) {
> +		if (!feature->ioaddr && feature->priv) {

Maybe we can add a new filed for ddev, then it will simplify
the checking. How do you think?

> +			ddev =3D feature->priv;
> +			device_unregister(&ddev->dev);
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
> +	struct dfl_device *ddev;
> +
> +	dfl_fpga_dev_for_each_feature(pdata, feature) {
> +		if (feature->ioaddr || feature->priv)

Why checks priv here?

> +			continue;
> +
> +		ddev =3D dfl_dev_add(pdata, feature);
> +		if (IS_ERR(ddev)) {
> +			dfl_devs_uinit(pdata);
> +			return PTR_ERR(ddev);
> +		}
> +
> +		feature->priv =3D ddev;
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
>  #define is_header_feature(feature) ((feature)->id =3D=3D
> FEATURE_ID_FIU_HEADER)
>=20
>  /**
> @@ -261,12 +485,15 @@ void dfl_fpga_dev_feature_uinit(struct
> platform_device *pdev)
>  	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> >dev);
>  	struct dfl_feature *feature;
>=20
> -	dfl_fpga_dev_for_each_feature(pdata, feature)
> +	dfl_devs_uinit(pdata);

Then you loop each feature twice, but they can be done in one loop ideally?

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
> @@ -347,6 +574,10 @@ int dfl_fpga_dev_feature_init(struct
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
> @@ -1284,11 +1515,17 @@ static int __init dfl_fpga_init(void)
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
> @@ -1626,6 +1863,7 @@ static void __exit dfl_fpga_exit(void)
>  {
>  	dfl_chardev_uinit();
>  	dfl_ids_destroy();
> +	bus_unregister(&dfl_bus_type);
>  }
>=20
>  module_init(dfl_fpga_init);
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 5973769..667e1c9 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -514,4 +514,88 @@ long dfl_feature_ioctl_set_irq(struct
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
> + * @feature_id: 16 bits feature identifier local to its DFL FIU type.

Actually 12bits are used.

> + * @driver_data: Driver specific data
> + */
> +struct dfl_device_id {
> +	unsigned int type;
> +	u16 feature_id;
> +	unsigned long driver_data;
> +};
> +
> +/**
> + * struct dfl_device - represent an dfl device on dfl bus
> + *
> + * @dev: Generic device interface.
> + * @id: id of the dfl device
> + * @type: Type of DFL FIU of the device. See enum dfl_id_type.
> + * @feature_id: 16 bits feature identifier local to its DFL FIU type.
> + * @mmio_res: MMIO resource of this dfl device.
> + * @irqs: List of Linux IRQ numbers of this dfl device.
> + * @num_irqs: number of IRQs supported by this dfl device.
> + * @cdev: pointer to DFL FPGA container device this dfl device belongs t=
o.
> + * @id_entry: matched id entry in dfl driver's id table.
> + */
> +struct dfl_device {
> +	struct device dev;
> +	int id;
> +	unsigned int type;
> +	u16 feature_id;
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
> + *	      { } member terminated.
> + * @probe: Callback for device binding.

Please add "Mandatory callback" in the description.

Thanks
Hao

> + * @remove: Callback for device unbinding.
> + */
> +struct dfl_driver {
> +	struct device_driver drv;
> +	const struct dfl_device_id *id_table;
> +
> +	int (*probe)(struct dfl_device *dfl_dev);
> +	void (*remove)(struct dfl_device *dfl_dev);
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
> +/*
> + * module_dfl_driver() - Helper macro for drivers that don't do
> + * anything special in module init/exit.  This eliminates a lot of
> + * boilerplate.  Each module may only use this macro once, and
> + * calling it replaces module_init() and module_exit()
> + */
> +#define module_dfl_driver(__dfl_driver) \
> +	module_driver(__dfl_driver, dfl_driver_register, \
> +		      dfl_driver_unregister)
> +
>  #endif /* __FPGA_DFL_H */
> --
> 2.7.4

