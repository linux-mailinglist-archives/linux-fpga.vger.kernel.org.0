Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2921ABCE4
	for <lists+linux-fpga@lfdr.de>; Thu, 16 Apr 2020 11:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503577AbgDPJem (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 16 Apr 2020 05:34:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:35594 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503615AbgDPJee (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 16 Apr 2020 05:34:34 -0400
IronPort-SDR: 7SYLj21VDyh2twUmwMLmUGczeyKF9DZg2JOFme9Gv9qc+HggwgVXIqFfGHNTxvJDqZ1R/zE/P7
 B2nkSrSU7BNw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 02:34:30 -0700
IronPort-SDR: 3Bn5y773cCOfG5TUO7BDTciWkIYjlKBCJwv2BnVMRiM3R30RAQRP/YCowF4jFV02ioh6zW+rdm
 UnCYJXoqbuOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="363934012"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2020 02:34:30 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 02:34:30 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 16 Apr 2020 02:34:29 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 16 Apr 2020 02:34:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 16 Apr 2020 02:34:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+DhzVZ/OilgxbeR/tOsbNyZpK2cctktD+oZQ8OaBKj6wPWNNCvqaY7E5G9au82Fqt+PfrBAd60+4+cpm/AND5cEUrub/xR1fO8qQxGz1ker3VOyuctatbOCdW5GFN9cM5NZA3k887btfpdTB5qf0Nbjy9DY30yiB0VZFej2L3bEHH8/xTvqU4oMmqbHSopZEnXPsDeW8bnIOoZy3/QIta28KwGycLckZrT+dgy/1rq88wN7NB9zgS40Y1YZqbRIY3eev/yH29oJL/BVWwvUR1xpkaXGszGE7UDDXgmmjh65e2HcJqn4UKvIDOvk2rsljDHMokC+/GJLXXVF75F/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5F0qu8vZ1CG6Uto+NEbPklLyNYmhoVbP0767W7KN6w=;
 b=l4485lN7BDjOxGBEv3tdlraozmMMBpMIYC1SC1uedkGbrkzyAFkqhz/KiMMjiZ3FHE4KowotUscSiJoZA5ShYYkChutqDOwppaLHav/YGGygqoDjqqUjkTOqbHAZi+oSjdsU8m/iJO2d+Txe1eLlkBqNr+1qla+eYwZT1BvYO5zZj0TBfBCS6BdsDop/7Nm6lCHaaPXw+Ys7UgVK3rs3+4g/tuxEV7bSFmB81TAiX7NxMbAW9BRZ4fdaHgREAfYHFgwdY467QIp9EBbpQOcsZfDelO6dZ79RAPVwf7eZcfl6KnlCH37/NSHABrV48MoE/5pV9/2rLojocTLKGm6Q6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5F0qu8vZ1CG6Uto+NEbPklLyNYmhoVbP0767W7KN6w=;
 b=b7L8oPUsbQDYYOwhBb4fzhfCuyxxTDmJbrrhJudd9z4DqpLR8xRO3QzH0q1QAajOWI66d34j5mHNvNYmKfZOA/tWASDopGNZ5qcxXmmdtmxgXgQebstTxx6Zm672B0aX6sndSGPhxXiFwb4T1LfJ7L5KDDEk550bAZfNAvVW7D0=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3980.namprd11.prod.outlook.com (2603:10b6:5:192::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Thu, 16 Apr
 2020 09:34:21 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::98a:bb06:5551:e5a3]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::98a:bb06:5551:e5a3%3]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 09:34:21 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "bhu@redhat.com" <bhu@redhat.com>,
        "Kang, Luwei" <luwei.kang@intel.com>
Subject: RE: [PATCH v4 3/7] fpga: dfl: introduce interrupt trigger setting API
Thread-Topic: [PATCH v4 3/7] fpga: dfl: introduce interrupt trigger setting
 API
Thread-Index: AQHWEw4rQUcFYG42a0G/qcDWh3UJPKh7e7gw
Date:   Thu, 16 Apr 2020 09:34:20 +0000
Message-ID: <DM6PR11MB38190A5AF05693BAF61DC97485D80@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1586945255-30823-1-git-send-email-yilun.xu@intel.com>
 <1586945255-30823-4-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1586945255-30823-4-git-send-email-yilun.xu@intel.com>
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
x-ms-office365-filtering-correlation-id: 17808e84-40ae-40bf-8001-08d7e1e957ae
x-ms-traffictypediagnostic: DM6PR11MB3980:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3980F8128F9041441F85DE6485D80@DM6PR11MB3980.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:88;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(396003)(366004)(346002)(136003)(39860400002)(376002)(110136005)(316002)(33656002)(64756008)(66556008)(5660300002)(54906003)(2906002)(66946007)(76116006)(66446008)(8936002)(66476007)(52536014)(26005)(71200400001)(9686003)(6506007)(107886003)(7696005)(81156014)(53546011)(86362001)(55016002)(4326008)(478600001)(8676002)(186003)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wjggcp1zbSqHidCUJAMGZvZdOO/MmrZav2REXLc4ylfqLJyfd8goXrNzENdgbKgxlhnQEnnObiup6Ausye7lTUPQjRq3weLiFUwNyePo1iC14oU31ObXaItpb/6MtqbOOR7+5zk1AgjkSjkrulhBzQmUCu2PokGB+geFzpQtp6UZ4PEC9oBxJmQihm0QO0dWRhmUeD/7aMmslRnxMuOyKboh4F7BOP3wFTecbtaWD3ZbgD49Hgz9ZKSbY932YL2hf8VrGplyfF5yMpO+GxaPAwuyEwH67D6HfwBTzKaEi9Urg0AY8Ozot98ow+Nt5eF0ww8dhqGUo7J1X2t6npVivSJjC6C2CJafeOUiRkrjgIZ8VAGSUacG3gJgF02hMPSA/Wa+Yo2EvN0m7gZU97BiOYnu0IdVHCYPzORfClsHhU03YtLoEwXDsUlKN+Xwje9/rb6sMRJbonivw8weuYBTFpKIhlK+3Hxrf0qaZgSoYSZwj5pMzQ9CLyCe/5fhSUjL
x-ms-exchange-antispam-messagedata: Vkw5yPaC6+ZjEiKHtVO5yiHFFsVj2OQ979voN9r8hlmnnyLC9yxVXXYf1FVXtkZig58wHou1k6/8qdAdE7KfubiLrzHxYS8CY9UHkLUhXmBtt3o/e2I51XhdLVSarLWHolOC1XzKjsS10Xb0arTAng==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 17808e84-40ae-40bf-8001-08d7e1e957ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 09:34:20.9778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LtbMfdLHTOkuyw3GgSLc9uiYkiOnmwTSOeP9TsjQS95OsTOxcRreCKR2VgDixo8l9ekF21sDy9dPAtDlXmZHNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3980
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
> Subject: [PATCH v4 3/7] fpga: dfl: introduce interrupt trigger setting AP=
I
>=20
> FPGA user applications may be interested in interrupts generated by
> DFL features. For example, users can implement their own FPGA
> logics with interrupts enabled in AFU (Accelerated Function Unit,
> dynamic region of DFL based FPGA). So user applications need to be
> notified to handle these interrupts.
>=20
> In order to allow userspace applications to monitor interrupts,
> driver requires userspace to provide eventfds as interrupt
> notification channels. Applications then poll/select on the eventfds
> to get notified.
>=20
> This patch introduces a generic helper functions to do eventfds binding
> with given interrupts.
>=20
> Sub feature drivers are expected to use XXX_GET_IRQ_NUM to query irq
> info, and XXX_SET_IRQ to set eventfds for interrupts. This patch also
> introduces helper functions for these 2 ioctls.
>=20
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>

With some minor fixings below, =20

Acked-by: Wu Hao <hao.wu@intel.com>

> ----
> v2: use unsigned int instead of int for irq array indexes in
>     dfl_fpga_set_irq_triggers()
>     Improves comments for NULL fds param in dfl_fpga_set_irq_triggers()
> v3: Improve comments of dfl_fpga_set_irq_triggers()
>     refines code for dfl_fpga_set_irq_triggers, delete local variable j
> v4: Introduce 2 helper functions to help handle the XXX_GET_IRQ_NUM &
>     XXX_SET_IRQ ioctls for sub feature drivers.
> ---
>  drivers/fpga/dfl.c            | 156
> ++++++++++++++++++++++++++++++++++++++++++
>  drivers/fpga/dfl.h            |  17 +++++
>  include/uapi/linux/fpga-dfl.h |  13 ++++
>  3 files changed, 186 insertions(+)
>=20
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 9e5930e..cab7746 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -11,6 +11,8 @@
>   *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
>   */
>  #include <linux/module.h>
> +#include <linux/uaccess.h>
> +#include <linux/fpga-dfl.h>

Just a minor one. maybe we can reorder these header files from A - Z
(and same applies to other patches as well).

>=20
>  #include "dfl.h"
>=20
> @@ -534,6 +536,7 @@ static int build_info_commit_dev(struct
> build_feature_devs_info *binfo)
>  		unsigned int i;
>=20
>  		/* save resource information for each feature */
> +		feature->dev =3D fdev;
>  		feature->id =3D finfo->fid;
>  		feature->resource_index =3D index;
>  		feature->ioaddr =3D finfo->ioaddr;
> @@ -1396,6 +1399,159 @@ int dfl_fpga_cdev_config_ports_vf(struct
> dfl_fpga_cdev *cdev, int num_vfs)
>  }
>  EXPORT_SYMBOL_GPL(dfl_fpga_cdev_config_ports_vf);
>=20
> +static irqreturn_t dfl_irq_handler(int irq, void *arg)
> +{
> +	struct eventfd_ctx *trigger =3D arg;
> +
> +	eventfd_signal(trigger, 1);
> +	return IRQ_HANDLED;
> +}
> +
> +static int do_set_irq_trigger(struct dfl_feature *feature, unsigned int =
idx,
> +			      int fd)
> +{
> +	struct platform_device *pdev =3D feature->dev;
> +	struct eventfd_ctx *trigger;
> +	int irq, ret;
> +
> +	if (idx >=3D feature->nr_irqs)
> +		return -EINVAL;
> +
> +	irq =3D feature->irq_ctx[idx].irq;
> +
> +	if (feature->irq_ctx[idx].trigger) {
> +		free_irq(irq, feature->irq_ctx[idx].trigger);
> +		kfree(feature->irq_ctx[idx].name);
> +		eventfd_ctx_put(feature->irq_ctx[idx].trigger);
> +		feature->irq_ctx[idx].trigger =3D NULL;
> +	}
> +
> +	if (fd < 0)
> +		return 0;
> +
> +	feature->irq_ctx[idx].name =3D
> +		kasprintf(GFP_KERNEL, "fpga-irq[%u](%s-%llx)", idx,
> +			  dev_name(&pdev->dev),
> +			  (unsigned long long)feature->id);
> +	if (!feature->irq_ctx[idx].name)
> +		return -ENOMEM;
> +
> +	trigger =3D eventfd_ctx_fdget(fd);
> +	if (IS_ERR(trigger)) {
> +		ret =3D PTR_ERR(trigger);
> +		goto free_name;
> +	}
> +
> +	ret =3D request_irq(irq, dfl_irq_handler, 0,
> +			  feature->irq_ctx[idx].name, trigger);
> +	if (!ret) {
> +		feature->irq_ctx[idx].trigger =3D trigger;
> +		return ret;
> +	}
> +
> +	eventfd_ctx_put(trigger);
> +free_name:
> +	kfree(feature->irq_ctx[idx].name);
> +
> +	return ret;
> +}
> +
> +/**
> + * dfl_fpga_set_irq_triggers - set eventfd triggers for dfl feature inte=
rrupts
> + *
> + * @feature: dfl sub feature.
> + * @start: start of irq index in this dfl sub feature.
> + * @count: number of irqs.
> + * @fds: eventfds to bind with irqs. unbind related irq if fds[n] is neg=
ative.
> + *	 unbind "count" specified number of irqs if fds ptr is NULL.
> + *
> + * Bind given eventfds with irqs in this dfl sub feature. Unbind related=
 irq if
> + * fds[n] is negative. Unbind "count" specified number of irqs if fds pt=
r is
> + * NULL.
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +int dfl_fpga_set_irq_triggers(struct dfl_feature *feature, unsigned int =
start,
> +			      unsigned int count, int32_t *fds)
> +{
> +	unsigned int i;
> +	int ret =3D 0;
> +
> +	if (start + count < start || start + count > feature->nr_irqs)
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < count; i++) {
> +		int fd =3D fds ? fds[i] : -1;
> +
> +		ret =3D do_set_irq_trigger(feature, start + i, fd);
> +		if (ret) {
> +			while (i--)
> +				do_set_irq_trigger(feature, start + i, -1);
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dfl_fpga_set_irq_triggers);
> +
> +/**
> + * dfl_feature_ioctl_get_num_irqs - dfl feature _GET_IRQ_NUM ioctl
> interface.
> + * @pdev: the feature device which has the sub feature
> + * @feature: the dfl sub feature
> + * @arg: ioctl argument
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +long dfl_feature_ioctl_get_num_irqs(struct platform_device *pdev,
> +				    struct dfl_feature *feature,
> +				    unsigned long arg)
> +{
> +	return put_user(feature->nr_irqs, (__u32 __user *)arg);
> +}
> +EXPORT_SYMBOL_GPL(dfl_feature_ioctl_get_num_irqs);
> +
> +/**
> + * dfl_feature_ioctl_set_irq - dfl feature _SET_IRQ ioctl interface.
> + * @pdev: the feature device which has the sub feature
> + * @feature: the dfl sub feature
> + * @arg: ioctl argument
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
> +			       struct dfl_feature *feature,
> +			       unsigned long arg)
> +{
> +	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> >dev);
> +	struct dfl_fpga_irq_set hdr;
> +	s32 *fds;
> +	long ret;
> +
> +	if (!feature->nr_irqs)
> +		return -ENOENT;
> +
> +	if (copy_from_user(&hdr, (void __user *)arg, sizeof(hdr)))
> +		return -EFAULT;
> +
> +	if (!hdr.count || (hdr.start + hdr.count > feature->nr_irqs) ||
> +	    (hdr.start + hdr.count < hdr.start))
> +		return -EINVAL;
> +
> +	fds =3D memdup_user((void __user *)(arg + sizeof(hdr)),
> +			  hdr.count * sizeof(s32));
> +	if (IS_ERR(fds))
> +		return PTR_ERR(fds);
> +
> +	mutex_lock(&pdata->lock);
> +	ret =3D dfl_fpga_set_irq_triggers(feature, hdr.start, hdr.count, fds);
> +	mutex_unlock(&pdata->lock);
> +
> +	kfree(fds);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dfl_feature_ioctl_set_irq);
> +
>  static void __exit dfl_fpga_exit(void)
>  {
>  	dfl_chardev_uinit();
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 4bc165f..0163535 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -24,6 +24,8 @@
>  #include <linux/slab.h>
>  #include <linux/uuid.h>
>  #include <linux/fpga/fpga-region.h>
> +#include <linux/interrupt.h>
> +#include <linux/eventfd.h>
>=20
>  /* maximum supported number of ports */
>  #define MAX_DFL_FPGA_PORT_NUM 4
> @@ -213,14 +215,19 @@ struct dfl_feature_driver {
>   * struct dfl_feature_irq_ctx - dfl private feature interrupt context
>   *
>   * @irq: Linux IRQ number of this interrupt.
> + * @trigger: eventfd context to signal when interrupt happens.
> + * @name: irq name needed when requesting irq.
>   */
>  struct dfl_feature_irq_ctx {
>  	int irq;
> +	struct eventfd_ctx *trigger;
> +	char *name;
>  };
>=20
>  /**
>   * struct dfl_feature - sub feature of the feature devices
>   *
> + * @dev: ptr to pdev of the feature device which has the sub feature.
>   * @id: sub feature id.
>   * @resource_index: each sub feature has one mmio resource for its
> registers.
>   *		    this index is used to find its mmio resource from the
> @@ -231,6 +238,7 @@ struct dfl_feature_irq_ctx {
>   * @ops: ops of this sub feature.
>   */
>  struct dfl_feature {
> +	struct platform_device *dev;
>  	u64 id;
>  	int resource_index;
>  	void __iomem *ioaddr;
> @@ -506,4 +514,13 @@ int dfl_fpga_cdev_release_port(struct dfl_fpga_cdev
> *cdev, int port_id);
>  int dfl_fpga_cdev_assign_port(struct dfl_fpga_cdev *cdev, int port_id);
>  void dfl_fpga_cdev_config_ports_pf(struct dfl_fpga_cdev *cdev);
>  int dfl_fpga_cdev_config_ports_vf(struct dfl_fpga_cdev *cdev, int num_vf=
);
> +int dfl_fpga_set_irq_triggers(struct dfl_feature *feature, unsigned int =
start,
> +			      unsigned int count, int32_t *fds);
> +long dfl_feature_ioctl_get_num_irqs(struct platform_device *pdev,
> +				    struct dfl_feature *feature,
> +				    unsigned long arg);
> +long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
> +			       struct dfl_feature *feature,
> +			       unsigned long arg);
> +
>  #endif /* __FPGA_DFL_H */
> diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-dfl.=
h
> index ec70a0746..8a5979e 100644
> --- a/include/uapi/linux/fpga-dfl.h
> +++ b/include/uapi/linux/fpga-dfl.h
> @@ -151,6 +151,19 @@ struct dfl_fpga_port_dma_unmap {
>=20
>  #define DFL_FPGA_PORT_DMA_UNMAP
> 	_IO(DFL_FPGA_MAGIC, DFL_PORT_BASE + 4)
>=20
> +/**
> + * struct dfl_fpga_irq_set - the argument for DFL_FPGA_XXX_SET_IRQ ioctl=
.
> + *
> + * @start: Index of the first irq.
> + * @count: The number of eventfd handler.
> + * @evtfds: Eventfd handler.

s/handler/handlers/

> + */
> +struct dfl_fpga_irq_set {
> +	__u32 start;
> +	__u32 count;
> +	__s32 evtfds[];
> +};
> +
>  /* IOCTLs for FME file descriptor */
>=20
>  /**
> --
> 2.7.4

