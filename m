Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F301ABD29
	for <lists+linux-fpga@lfdr.de>; Thu, 16 Apr 2020 11:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503878AbgDPJp4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 16 Apr 2020 05:45:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:55876 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503578AbgDPJpx (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 16 Apr 2020 05:45:53 -0400
IronPort-SDR: ELYlUpjGvOuZ3rTdygjYNTLKrFbpJY6YSiPMQSQ4yoqDU8RSuJBuuPsXtR6V5cpHF6KNqm/dZP
 ytZODRUEzY3A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 02:45:53 -0700
IronPort-SDR: Vjv/GmOwlsebOxPDRC3wImfq81bJMDT/FdQ4IPjQV10A4WSsQmIlRSbgG4BDikTlvyQXmKfawY
 UDoD+og3Xs6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="454267750"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga005.fm.intel.com with ESMTP; 16 Apr 2020 02:45:53 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 02:45:51 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 16 Apr 2020 02:45:51 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 16 Apr 2020 02:45:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 16 Apr 2020 02:45:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJKrgipFj9a0Kcgcdq66p8b7eA9cjR+hIpIJnLP4rj8lDPWeYvPsHJ+q16SyaPduVOJp26dD8T5ax0cueZr8yIRhOsB4pddGuHb6QN/KObiWh5wwjgZ67iiXv0GZt7Q6ArFYM3OBLPU6xW7DzqHmhx2Q4cxNSWDy1eH1l+jyNO/LDSqNqgW56AxY6mj8978/hIvGEpLtuNBo/FwbsmjxGXM+r7O93cN2GcrpaW3C5y81Y3QPRJ4+TSXfyV+6i0RbHIns+9X9EOHM5ZOvUk5aTzsz2CVpI6pk5sSopujnPexOqfuya7jrRHfP5Q79sP+uN+Px/KjlK3M3MhtSbn70fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Phfd5DPAWS6cz+aRTl32DaNr2gtEP+ZrDm1Ipr6M+NI=;
 b=beH6gTffM2FCeNZs0EmpiBUSP4wWYAH2ZocJ1vZfLkBJsNetQu8o3mZZclYb5FLvQSfnEJm5qs36hqtzB9EXNEFFGI0nfcssvHaCaJ5u/VWg2Fj0SgAiry1hth9G4lXOFt/2WX+DpS2r3mpyAJYwCEpXmttngREWEHV0FopXOFfWQ78eGzvXzwM3yBx8ZKwBf5Q3AWWKbfiuro78llRXyxel9IOeuZ9mVH9ZaE2HOdtNls88GS0j/T+5L+3LnkWsLZ5O2vv2JealYDr8AZoeYCcLH2FD1/9sMXaAOwM1EUuEJIGhWBgD4Eo/DkDSfmZx4o/2OOkB0l95rkzcWGBn8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Phfd5DPAWS6cz+aRTl32DaNr2gtEP+ZrDm1Ipr6M+NI=;
 b=jpMJQjhSz9tqn7UJB9KqFE6mubPGlB1L4o55KAPS9fst5aueNu+qx8HThKwehmUymdrJ7hIZbkfBTxLQgb/OZhBsRc+A9gngmXzzSqkvuGb3s0idVuk0I2IQZEa/rDEdfBhWLeq3CcXB1oFsXY27T3KPU0B8fplgZNDrECPJU3Y=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3834.namprd11.prod.outlook.com (2603:10b6:5:137::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Thu, 16 Apr
 2020 09:45:46 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::98a:bb06:5551:e5a3]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::98a:bb06:5551:e5a3%3]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 09:45:46 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "bhu@redhat.com" <bhu@redhat.com>,
        "Kang, Luwei" <luwei.kang@intel.com>
Subject: RE: [PATCH v4 4/7] fpga: dfl: afu: add interrupt support for port
 error reporting
Thread-Topic: [PATCH v4 4/7] fpga: dfl: afu: add interrupt support for port
 error reporting
Thread-Index: AQHWEw4uKRp6wQvBC0aEtVf/7iqLQqh7fluQ
Date:   Thu, 16 Apr 2020 09:45:46 +0000
Message-ID: <DM6PR11MB3819E93B47AD06083F4DC5BB85D80@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1586945255-30823-1-git-send-email-yilun.xu@intel.com>
 <1586945255-30823-5-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1586945255-30823-5-git-send-email-yilun.xu@intel.com>
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
x-ms-office365-filtering-correlation-id: ff0b0e08-6eb4-4b68-49ab-08d7e1eaf062
x-ms-traffictypediagnostic: DM6PR11MB3834:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB383462E1278893C03ADD979585D80@DM6PR11MB3834.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39860400002)(346002)(376002)(366004)(396003)(136003)(110136005)(316002)(26005)(478600001)(6506007)(33656002)(7696005)(53546011)(2906002)(8676002)(5660300002)(81156014)(52536014)(54906003)(66946007)(66446008)(4326008)(186003)(9686003)(86362001)(55016002)(8936002)(76116006)(66476007)(64756008)(71200400001)(66556008)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aIcMxSeyBNY5wKJzmP02Qcijc5kWM8AjwM9ZmdHRabcluZwWNMgTTt/TbCxpgz2gjJzCQzbSUqEJx39GOv4FGVgt1xevKLo0/k2WQxRpMN2O9Ei8GrxwfVowUCFenwE5iCmMaJ6tEeiZSxsuzi6uSQ9SJo6lNUvbLVGzs8qRgDIdoZFRZCpw5A5cIws8FiCegBsAoeouo8F8XmW03l+/impfvVWZULbcVx0ZoBtdOIj3dNsTHYI6854QW5poqajx0ex1DwwdaWR+oSjFjWkQ371FZ8iTV9m/ovHAlD4AJqBpBV83U99zpoVIv+1zsZmtSw7fgJDXoM6zAccC0uYaR7bh0+e4fYWtYY6b9gRBi4sNzeWJj3QD6F0tbPWSoIfzxW+AwtVgCsYKjDYCBpTDzIcm9NgoBpoyf8nCTZhHGngJX1U5bRQ5F+z32Y/DC5iD
x-ms-exchange-antispam-messagedata: BUwvWWwnZKo3/rPk2B1/H7eCc2QP+DnuWJ54Tg0g05sNBW5AQc6tLgTmaGMGn9LzD+8Cx/SLZWVcv+kT3hqnKTMNb/koORAiUJval+/mqv9OIRFLmaXm/N7Fzd3AL7eMfEW6TrivXAF/RVC44rB0jQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0b0e08-6eb4-4b68-49ab-08d7e1eaf062
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 09:45:46.7085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r/WsrcAcl4vvfs0yG2I+gJrxvktp1HhJHvF4D2oRlFeX3D+RD957ygtmeZHIEt8us6FYo57Sz7EdGlbgvWGS6A==
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
> Subject: [PATCH v4 4/7] fpga: dfl: afu: add interrupt support for port er=
ror
> reporting
>=20
> Error reporting interrupt is very useful to notify users that some
> errors are detected by the hardware. Once users are notified, they
> could query hardware logged error states, no need to continuously
> poll on these states.
>=20
> This patch adds interrupt support for port error reporting sub feature.
> It follows the common DFL interrupt notification and handling mechanism,
> implements two ioctl commands below for user to query number of irqs
> supported, and set/unset interrupt triggers.
>=20
>  Ioctls:
>  * DFL_FPGA_PORT_ERR_GET_IRQ_NUM
>    get the number of irqs, which is used to determine whether/how many
>    interrupts error reporting feature supports.
>=20
>  * DFL_FPGA_PORT_ERR_SET_IRQ
>    set/unset given eventfds as error interrupt triggers.
>=20
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ----
> v2: use DFL_FPGA_PORT_ERR_GET_IRQ_NUM instead of
>     DFL_FPGA_PORT_ERR_GET_INFO
>     Delete flag field for DFL_FPGA_PORT_ERR_SET_IRQ param
> v3: put_user() instead of copy_to_user()
>     improves comments
> v4: use common functions to handle irq ioctls
> ---
>  drivers/fpga/dfl-afu-error.c  | 22 ++++++++++++++++++++++
>  drivers/fpga/dfl-afu-main.c   |  4 ++++
>  include/uapi/linux/fpga-dfl.h | 23 +++++++++++++++++++++++
>  3 files changed, 49 insertions(+)
>=20
> diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
> index c1467ae..facbd7b 100644
> --- a/drivers/fpga/dfl-afu-error.c
> +++ b/drivers/fpga/dfl-afu-error.c
> @@ -15,6 +15,7 @@
>   */
>=20
>  #include <linux/uaccess.h>
> +#include <linux/fpga-dfl.h>

Same.  : )

>=20
>  #include "dfl-afu.h"
>=20
> @@ -219,6 +220,26 @@ static void port_err_uinit(struct platform_device
> *pdev,
>  	afu_port_err_mask(&pdev->dev, true);
>  }
>=20
> +static long
> +port_err_ioctl(struct platform_device *pdev, struct dfl_feature *feature=
,
> +	       unsigned int cmd, unsigned long arg)
> +{
> +	long ret =3D -ENODEV;
> +
> +	switch (cmd) {
> +	case DFL_FPGA_PORT_ERR_GET_IRQ_NUM:
> +		ret =3D dfl_feature_ioctl_get_num_irqs(pdev, feature, arg);
> +		break;
> +	case DFL_FPGA_PORT_ERR_SET_IRQ:
> +		ret =3D dfl_feature_ioctl_set_irq(pdev, feature, arg);
> +		break;
> +	default:
> +		dev_dbg(&pdev->dev, "%x cmd not handled", cmd);
> +	}
> +
> +	return ret;
> +}

Looks like we don't have to introduce this local 'ret'.

With above fixings:

Acked-by: Wu Hao <hao.wu@intel.com>

Thanks
Hao
