Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E037F1ABD3F
	for <lists+linux-fpga@lfdr.de>; Thu, 16 Apr 2020 11:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504203AbgDPJso (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 16 Apr 2020 05:48:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:63822 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504126AbgDPJsh (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 16 Apr 2020 05:48:37 -0400
IronPort-SDR: drNFHjEeXl7DGqHhua/GDKvw7OVpjoktN3JGuEy9dX5ie8/ZuGanb7B77lt5Pi43ay69Lcw2LB
 TPJXSuFtyQyQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 02:48:31 -0700
IronPort-SDR: wL3njhJkGut5DF2SN985WpBAthwzTrFL94B6JKx80uvQKxmKALNU0BtdNEMn1ZoxQkG4Go6Hux
 5RK2wC/OMuiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="242599418"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga007.jf.intel.com with ESMTP; 16 Apr 2020 02:48:31 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 02:48:31 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 16 Apr 2020 02:48:30 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 16 Apr 2020 02:48:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 02:48:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7f5b7YDue6amdfPxheAb/WQyv0im0OyCMKI56k0JqWhmQHt/w0XYyzD1/EC910FMLHPMGj08hTdR50xgAKGMSkHvCmbKIjwiVEx4yviGA2XvrYc/W6Dz6cPlv1bmH91tz7+XxcO8TFWLCO4UG2MU4Ub6dSMbnjPywBdFuvci2cNlqakucu4oQAvvadud/1XA4/QaBGy2+5ig1WY/PsGE+wVf9JPTfXWwdhwJkK9eU5vApAv6PEYJf3F3XN7NLoxRRMWYc5DqTOFwE+x+U9XFACU0tMM5RUCwXYDKaRDATCjwTHFgdIJEQPId1TOcDpQv5J4aNVpEpw1Rso7JEIDDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDZvfXGuknErF0hZ9/n6QDVNhdBo9TTnR1f9/DuHLIY=;
 b=BjPYccFah8WcDunbp8Y9DX4gJ4AYfLPOtci03OpyMQ5yo1JfBk8G8/TPQkrRGIWkP+YX6YSlL3iXrHxaqEn8oX/PAKsK3gEjs/4hbGSobpDMgkR2DCnSXDyVKLOBPqOjsozuTfCNpLmlWptpBqcnpuGPgPX+WP7jlI90bzL2RvlHwooCF1qfBkGRLtbmhIHiSlkQs8FpiYUT6mEPvzrV34OgY7+k8rzmgzr6zJRXRVR3gtDQVgIoJv9KIBlqzKetzHPkQxiG3//7v679b1yxAlE3dGAaFqUeEtc7jY1sLu0pvE26Ap/olQP11n33QyCJK8Qg+gEoP8qky2z78LjYdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDZvfXGuknErF0hZ9/n6QDVNhdBo9TTnR1f9/DuHLIY=;
 b=rCBrPVK3wNknbnmfXZJue5Az3xS2zP2MCFkypkzw7Hn9ELJm+LtZ/QSqJiOMrylfrg947YW+5CKzTRpwjKQrE0GnWVJCJrJBcXzPwzRfiVNWywLCSbA25V2GCFw1pWR4T9oqNrkUfhc6eWwgkxAAq38sARYxRFx2iMCKpHfORQY=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3834.namprd11.prod.outlook.com (2603:10b6:5:137::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Thu, 16 Apr
 2020 09:47:53 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::98a:bb06:5551:e5a3]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::98a:bb06:5551:e5a3%3]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 09:47:53 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "bhu@redhat.com" <bhu@redhat.com>,
        "Kang, Luwei" <luwei.kang@intel.com>
Subject: RE: [PATCH v4 5/7] fpga: dfl: fme: add interrupt support for global
 error reporting
Thread-Topic: [PATCH v4 5/7] fpga: dfl: fme: add interrupt support for global
 error reporting
Thread-Index: AQHWEw5ReWeaVzoLK0+zi/nRtLwP8Kh7gcmw
Date:   Thu, 16 Apr 2020 09:47:53 +0000
Message-ID: <DM6PR11MB3819E22A4BBA27F532476B4485D80@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1586945255-30823-1-git-send-email-yilun.xu@intel.com>
 <1586945255-30823-6-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1586945255-30823-6-git-send-email-yilun.xu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hao.wu@intel.com; 
x-originating-ip: [192.102.204.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 585b9beb-4134-409c-b570-08d7e1eb3c1e
x-ms-traffictypediagnostic: DM6PR11MB3834:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB38343F610A150D09B6524D1D85D80@DM6PR11MB3834.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39860400002)(346002)(376002)(366004)(396003)(136003)(110136005)(316002)(26005)(478600001)(6506007)(33656002)(7696005)(53546011)(2906002)(8676002)(5660300002)(81156014)(52536014)(54906003)(66946007)(66446008)(4326008)(186003)(9686003)(86362001)(55016002)(8936002)(76116006)(66476007)(64756008)(71200400001)(66556008)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cn+TNGhwCsOvMqyIueraK8eC7E2T8bmOyvSb9vO/gkjYjKDzI84zJL8G4oaeQqq7hYYRVf6P9d/+PVgioHBTeu84TKUSjoNx+uA8/+b51bod7OGBkG1DQ9/07t9ybjqSStQ3kyrJqmWKr943KJGupZj4FvD9ryjqH68XQl2UV98TBGLHjVgr7Vc2D8QD9fZPJUlRtEUPS86+HlM4lyR9e868C93VRsR0Ib7q+SRyAdQ3AX4qtppMd3eFewJNw7ossddBeUjMUYV5wZRTNtUGG2cy8LlKtzfPDpOkqEV28ir3+8YoL7EkSlprVKJ2Jaej9dxwgX8dJ81Qzh15TePs2991x05gqfvT++Y9TyZDxHRuiidVVxJnLiWVQXMwIY/cV5gUudc8WlI3VRHcxR8VOy7bYOXZPrV2/uQ97CFTt0kezS8M/VFvkmq+m3OAFPfc
x-ms-exchange-antispam-messagedata: HjtkSC5rGGPwJK0JRgTRR4M0SZUsJ/GYli2L2vukhWuN3zLetUBNVbnevPtdJnb7xWx5P0liGed8vM/3vYDZl9Q1hyjTM6IXm0jl76rhCNKI0qkm/XlHZtACbKOWXuTRqKTl1VmzjImj9N90wfEU2w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 585b9beb-4134-409c-b570-08d7e1eb3c1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 09:47:53.7334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pbCmg86lJ2GyIe40XrIY3yifoqNK+UUdSPIwwbsIVWOsBrsljcFbdQ+XOXhQHCE9nhzVhAyVphIP5a8P9RinMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3834
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> -----Original Message-----
> From: Xu, Yilun <yilun.xu@intel.com>
> Sent: Wednesday, April 15, 2020 6:08 PM
> To: mdf@kernel.org; linux-fpga@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: trix@redhat.com; bhu@redhat.com; Xu, Yilun <yilun.xu@intel.com>;
> Kang, Luwei <luwei.kang@intel.com>; Wu, Hao <hao.wu@intel.com>
> Subject: [PATCH v4 5/7] fpga: dfl: fme: add interrupt support for global =
error
> reporting
>=20
> Error reporting interrupt is very useful to notify users that some
> errors are detected by the hardware. Once users are notified, they
> could query hardware logged error states, no need to continuously
> poll on these states.
>=20
> This patch adds interrupt support for fme global error reporting sub
> feature. It follows the common DFL interrupt notification and handling
> mechanism. And it implements two ioctls below for user to query
> number of irqs supported, and set/unset interrupt triggers.
>=20
>  Ioctls:
>  * DFL_FPGA_FME_ERR_GET_IRQ_NUM
>    get the number of irqs, which is used to determine whether/how many
>    interrupts fme error reporting feature supports.
>=20
>  * DFL_FPGA_FME_ERR_SET_IRQ
>    set/unset given eventfds as fme error reporting interrupt triggers.
>=20
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ----
> v2: use DFL_FPGA_FME_ERR_GET_IRQ_NUM instead of
>     DFL_FPGA_FME_ERR_GET_INFO
>     Delete flags field for DFL_FPGA_FME_ERR_SET_IRQ
> v3: put_user() instead of copy_to_user()
>     improves comments
> v4: use common functions to handle irq ioctls
> ---
>  drivers/fpga/dfl-fme-error.c  | 23 +++++++++++++++++++++++
>  drivers/fpga/dfl-fme-main.c   |  6 ++++++
>  include/uapi/linux/fpga-dfl.h | 23 +++++++++++++++++++++++
>  3 files changed, 52 insertions(+)
>=20
> diff --git a/drivers/fpga/dfl-fme-error.c b/drivers/fpga/dfl-fme-error.c
> index f897d41..a4cbf8c 100644
> --- a/drivers/fpga/dfl-fme-error.c
> +++ b/drivers/fpga/dfl-fme-error.c
> @@ -16,6 +16,7 @@
>   */
>=20
>  #include <linux/uaccess.h>
> +#include <linux/fpga-dfl.h>
>=20
>  #include "dfl.h"
>  #include "dfl-fme.h"
> @@ -348,6 +349,27 @@ static void fme_global_err_uinit(struct
> platform_device *pdev,
>  	fme_err_mask(&pdev->dev, true);
>  }
>=20
> +static long
> +fme_global_error_ioctl(struct platform_device *pdev,
> +		       struct dfl_feature *feature,
> +		       unsigned int cmd, unsigned long arg)
> +{
> +	long ret =3D -ENODEV;

Same case for patch #5 and #6.=20
Other place looks good to me.

Thanks
Hao

> +
> +	switch (cmd) {
> +	case DFL_FPGA_FME_ERR_GET_IRQ_NUM:
> +		ret =3D dfl_feature_ioctl_get_num_irqs(pdev, feature, arg);
> +		break;
> +	case DFL_FPGA_FME_ERR_SET_IRQ:
> +		ret =3D dfl_feature_ioctl_set_irq(pdev, feature, arg);
> +		break;
> +	default:
> +		dev_dbg(&pdev->dev, "%x cmd not handled", cmd);
> +	}
> +
> +	return ret;
> +}
> +
>  const struct dfl_feature_id fme_global_err_id_table[] =3D {
>  	{.id =3D FME_FEATURE_ID_GLOBAL_ERR,},
>  	{0,}
> @@ -356,4 +378,5 @@ const struct dfl_feature_id fme_global_err_id_table[]
> =3D {
>  const struct dfl_feature_ops fme_global_err_ops =3D {
>  	.init =3D fme_global_err_init,
>  	.uinit =3D fme_global_err_uinit,
> +	.ioctl =3D fme_global_error_ioctl,
>  };
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index 56d720c..ab3722d 100644
> --- a/drivers/fpga/dfl-fme-main.c
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -616,11 +616,17 @@ static int fme_release(struct inode *inode, struct
> file *filp)
>  {
>  	struct dfl_feature_platform_data *pdata =3D filp->private_data;
>  	struct platform_device *pdev =3D pdata->dev;
> +	struct dfl_feature *feature;
>=20
>  	dev_dbg(&pdev->dev, "Device File Release\n");
>=20
>  	mutex_lock(&pdata->lock);
>  	dfl_feature_dev_use_end(pdata);
> +
> +	if (!dfl_feature_dev_use_count(pdata))
> +		dfl_fpga_dev_for_each_feature(pdata, feature)
> +			dfl_fpga_set_irq_triggers(feature, 0,
> +						  feature->nr_irqs, NULL);
>  	mutex_unlock(&pdata->lock);
>=20
>  	return 0;
> diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-dfl.=
h
> index fbe1e99..9e12fff 100644
> --- a/include/uapi/linux/fpga-dfl.h
> +++ b/include/uapi/linux/fpga-dfl.h
> @@ -230,4 +230,27 @@ struct dfl_fpga_fme_port_pr {
>   */
>  #define DFL_FPGA_FME_PORT_ASSIGN     _IOW(DFL_FPGA_MAGIC,
> DFL_FME_BASE + 2, int)
>=20
> +/**
> + * DFL_FPGA_FME_ERR_GET_IRQ_NUM - _IOR(DFL_FPGA_MAGIC,
> DFL_FME_BASE + 3,
> + *							__u32 num_irqs)
> + *
> + * Get the number of irqs supported by the fpga fme error reporting priv=
ate
> + * feature. Currently hardware supports up to 1 irq.
> + * Return: 0 on success, -errno on failure.
> + */
> +#define DFL_FPGA_FME_ERR_GET_IRQ_NUM	_IOR(DFL_FPGA_MAGIC,
> 	\
> +					     DFL_FME_BASE + 3, __u32)
> +
> +/**
> + * DFL_FPGA_FME_ERR_SET_IRQ - _IOW(DFL_FPGA_MAGIC, DFL_FME_BASE
> + 4,
> + *						struct dfl_fpga_irq_set)
> + *
> + * Set fpga fme error reporting interrupt trigger if evtfds[n] is valid.
> + * Unset related interrupt trigger if evtfds[n] is a negative value.
> + * Return: 0 on success, -errno on failure.
> + */
> +#define DFL_FPGA_FME_ERR_SET_IRQ	_IOW(DFL_FPGA_MAGIC,
> 	\
> +					     DFL_FME_BASE + 4,	\
> +					     struct dfl_fpga_irq_set)
> +
>  #endif /* _UAPI_LINUX_FPGA_DFL_H */
> --
> 2.7.4

