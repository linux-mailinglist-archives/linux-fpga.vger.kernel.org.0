Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205692831BE
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Oct 2020 10:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgJEIT1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Oct 2020 04:19:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:36523 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgJEIT1 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 5 Oct 2020 04:19:27 -0400
IronPort-SDR: lqo+QCBrIi4sURiKp6r2xcw6AFNBFaFhchQ0BEaZzQ6nSf52HzEQuN0sMLHV+yVvcaZUdcGwJE
 b8H0AoKz4NzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9764"; a="151137523"
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="151137523"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 01:19:21 -0700
IronPort-SDR: 8357v1KC0QBbtzDFA2oc3ml7z4P22SytG7RDXiK7WaKgj0QnRNZkCeNQrkR+z7Fx26ocQw1Iqd
 obD8qiDJtfBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="417044612"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 05 Oct 2020 01:19:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 5 Oct 2020 01:19:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 5 Oct 2020 01:19:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 5 Oct 2020 01:19:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 5 Oct 2020 01:19:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hddy5QZME0K0ef03gIKWbvFe+EHvVO1a7tEbZAuWdzf2XTSZY78GTgEeHXTVI6dmSqFj08Bn31FyY1UX8N/W3/2twN1Z3NStkmuW2P49bkrPe0s56+Q6L97QsARME+ZgxWnlTVvxnm3HiKEYY8SGUgXRIYnAsQeQs45ABl6U8GzCzpn+Qgae/+aYKKdKrmIgZlFAF4MVeg+4OYAuCJ69421c9snTndWu2QSzF5YCu7k6WJ03MvpG7PqUwFXuvD6muNv9OXadDkPn2e9D7C+H8k51znEQnxdWfDjjkO0uLthmeWyG5VhRf9mTQxYG9bGsVWJQWB0bs/fWN3ylKJ6qbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jis0qSNvG8OaUWLPBVD1kJHBbXqtkNqzu8ZmUcNYAv8=;
 b=ijau42C3EijSka9sD8IZhWmQQeM+uiTun5PDHdrKCObK47I5k7T4Lk2SkHfycx2ZiGq9G4bfyBTCi7o8mOxo7EVLLeJsjZzx7FZ4FJa098ZCWGFY3usESXJ0QCBRTgtIg7kyMBmdZx4AdPF20jPLvhT4dQYbYDhvy0F1W63WK/uqgOVsf4G5Innp+Z/f+M95zrSVk+N5JgHrkMp+zORIsiXJLjfwly4HmeZhuSIgTzm3RLq8tipzwS3K6TgB7tVxLECjWrLaYhSoDdxBrOxSDIjnLvpQnubAQV5DV6x+Heviky2L5KVhRVc/768ecn5+rof6ez3m8EM7Y9a4EJIq3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jis0qSNvG8OaUWLPBVD1kJHBbXqtkNqzu8ZmUcNYAv8=;
 b=DreZbuM8B+SMHgca8oH20xpDh8xkbNnvy80qu6s9u8rqr9sEmzj34+O8yFI0P3l8GfyNLtlLtsprslwsPaJT/+wP9cOPELobRz+w0DBmvihbKIKepmoM0rfFUclfklCb952e8q6/4MiFHqc41KMZlj061dthoQhVOR0VZSbJxf8=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB4594.namprd11.prod.outlook.com (2603:10b6:5:2a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Mon, 5 Oct
 2020 08:19:13 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::8daf:2295:b5df:2c7e]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::8daf:2295:b5df:2c7e%3]) with mapi id 15.20.3433.043; Mon, 5 Oct 2020
 08:19:13 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Weight, Russell H" <russell.h.weight@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: RE: [PATCH v2 2/7] fpga: sec-mgr: enable secure updates
Thread-Topic: [PATCH v2 2/7] fpga: sec-mgr: enable secure updates
Thread-Index: AQHWmQyebhDx7niYFEi5VTkGtD0RFamIo4Bw
Date:   Mon, 5 Oct 2020 08:19:13 +0000
Message-ID: <DM6PR11MB38195987C3B51752D4912577850C0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20201002223701.1317-1-russell.h.weight@intel.com>
 <20201002223701.1317-3-russell.h.weight@intel.com>
In-Reply-To: <20201002223701.1317-3-russell.h.weight@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.215]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5c6dc97-d5c3-4367-ddd2-08d86907580f
x-ms-traffictypediagnostic: DM6PR11MB4594:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB459470A8410738FE4DB778EC850C0@DM6PR11MB4594.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:483;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XISTFp/45S529pLCUmtAfRCvFuPDzwMkFa7XOx2Y6BSStD52uI95iFAlFGS0Li2FszBCwE3g07R/j53j4oUKP9ttYSdQkltSvLaXsB0EShWIdXGXczx8PrgkQ7J3GRdA4+q5WEhzydoDdShPo7fJZ99Lu49jIk0wwVfzH4cfBnOoELXhff06lnl40y7icrFMB3JQ0qN/WtfEEgIbV7al0mjh3AQLNwcFxLvDr6D+jkYYGL9i3Q+JR4pZZSkR759jMz9Epb6WfuO9G8KvmfpgZ6YzSH1COYwRIBsm2kFsjYoJrfGURmbFFdPfw6FRuoDoVGUXN3I54ccv3ytoAJxY2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(107886003)(7696005)(83380400001)(6506007)(8676002)(478600001)(26005)(33656002)(9686003)(8936002)(15650500001)(53546011)(55016002)(186003)(86362001)(110136005)(54906003)(66476007)(66946007)(64756008)(66446008)(66556008)(316002)(4326008)(52536014)(30864003)(2906002)(5660300002)(76116006)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: G6gZ41nzQnF0m8CONU3vHiQHakubXYRnFk7+NirzipItFZ1iSsyt82yvKhCwP6LXn21HnUX8GHzV8HMw7aD6uRuPYN7Cqt2NmnawJ3dZxGdI2TsfTBiv5bPaSdYxYVkbojYPmvyHC0nnsZ1daEdTGlDuBTzO0VSQfbxFhVm5sG3tZqbMoCPyC+YwQHYCRcoOCUxbf81nQ3+ZXQLoTXK+04jxMpr50EAbGRxlAe8yZkHLvjx2JDDXJvwHftIcKMqoOSSwNvmHjUgYy4dHAQ2ZQCwFt7wzdqAZhO7/Te8Ty6G6SpeakxhvSyBQpUShA2p4wwMw5YJB/xdBjWcPSzH3c2aWOm7OEYMhUaeCLU5wjUUZvytOoF8C3bKeMmDB+h32F88k6x2DcRtwZGuJlWTC3RUAAISnGwqIsJVYviihmdFPJna14Yv0dj0EpMJ644aHv3Fj2+Ddt5rW5ohUAfX7qv2baEO93zf7qAD2z9l+knRMgs51SI15sfzcDMyII7F32fFpWSqapE/gNwn2gdQd/iRvaKQSw46gjjUGDNUBykfHn5bD2EXKNhyYu5Bz4Qoyh3+ATyuW1/gswCO4KB6g/X8DeQQVAMvIw+5ScXIxRYCa+wM2mBc+HIsx+9KT52z8xE1l2Moc3HNynIvVMILeWQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c6dc97-d5c3-4367-ddd2-08d86907580f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2020 08:19:13.4898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tn3s2JZCanxjKQcKDZF4pC7C1JKx4KQHQNPFc5vd+Bzg3sGHjRdBA7LF6RR3Rm5DgH723vaQQftbWaIpQ30Wqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4594
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> -----Original Message-----
> From: Russ Weight <russell.h.weight@intel.com>
> Sent: Saturday, October 3, 2020 6:37 AM
> To: mdf@kernel.org; linux-fpga@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: trix@redhat.com; lgoncalv@redhat.com; Xu, Yilun <yilun.xu@intel.com>;
> Wu, Hao <hao.wu@intel.com>; Gerlach, Matthew
> <matthew.gerlach@intel.com>; Weight, Russell H
> <russell.h.weight@intel.com>
> Subject: [PATCH v2 2/7] fpga: sec-mgr: enable secure updates
>=20
> Extend the FPGA Intel Security Manager class driver to
> include an update/filename sysfs node that can be used
> to initiate a security update.  The filename of a secure
> update file (BMC image, FPGA image, Root Entry Hash image,
> or Code Signing Key cancellation image) can be written to
> this sysfs entry to cause a secure update to occur.
>=20
> The write of the filename will return immediately, and the
> update will begin in the context of a kernel worker thread.
> This tool utilizes the request_firmware framework, which
> requires that the image file reside under /lib/firmware.
>=20
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v2:
>   - Bumped documentation date and version
>   - Removed explicit value assignments in enums
>   - Other minor code cleanup per review comments
> ---
>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     |  13 ++
>  drivers/fpga/ifpga-sec-mgr.c                  | 157 ++++++++++++++++++
>  include/linux/fpga/ifpga-sec-mgr.h            |  49 ++++++
>  3 files changed, 219 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> index 707958971bcb..4f375f132c34 100644
> --- a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> +++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> @@ -65,3 +65,16 @@ Contact:	Russ Weight <russell.h.weight@intel.com>
>  Description:	Read only. Returns number of times the user image for the
>  		static region has been flashed.
>  		Format: "%u".
> +
> +What:
> 	/sys/class/ifpga_sec_mgr/ifpga_secX/update/filename
> +Date:		Oct 2020
> +KernelVersion:  5.11
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Write only. Write the filename of an Intel image
> +		file to this sysfs file to initiate a secure
> +		update. The file must have an appropriate header
> +		which, among other things, identifies the target
> +		for the update. This mechanism is used to update
> +		BMC images, BMC firmware, Static Region images,
> +		and Root Entry Hashes, and to cancel Code Signing
> +		Keys (CSK).
> diff --git a/drivers/fpga/ifpga-sec-mgr.c b/drivers/fpga/ifpga-sec-mgr.c
> index f1caa4602ab3..7d5a4979554b 100644
> --- a/drivers/fpga/ifpga-sec-mgr.c
> +++ b/drivers/fpga/ifpga-sec-mgr.c
> @@ -5,8 +5,11 @@
>   * Copyright (C) 2019-2020 Intel Corporation, Inc.
>   */
>=20
> +#include <linux/delay.h>
> +#include <linux/firmware.h>
>  #include <linux/fpga/ifpga-sec-mgr.h>
>  #include <linux/idr.h>
> +#include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
> @@ -14,6 +17,8 @@
>  static DEFINE_IDA(ifpga_sec_mgr_ida);
>  static struct class *ifpga_sec_mgr_class;
>=20
> +#define WRITE_BLOCK_SIZE	0x4000

Maybe some comments here for this value or should this be a parameter
of ifpga sec mgr, provided from low level driver during initialization?

> +
>  #define to_sec_mgr(d) container_of(d, struct ifpga_sec_mgr, dev)
>=20
>  static ssize_t
> @@ -134,6 +139,96 @@ static struct attribute *sec_mgr_security_attrs[] =
=3D {
>  	NULL,
>  };
>=20
> +static void ifpga_sec_dev_error(struct ifpga_sec_mgr *imgr,
> +				enum ifpga_sec_err err_code)
> +{
> +	imgr->err_code =3D err_code;
> +	imgr->iops->cancel(imgr);
> +}
> +
> +static void progress_complete(struct ifpga_sec_mgr *imgr)
> +{
> +	mutex_lock(&imgr->lock);
> +	imgr->progress =3D IFPGA_SEC_PROG_IDLE;
> +	complete_all(&imgr->update_done);
> +	mutex_unlock(&imgr->lock);
> +}
> +
> +static void ifpga_sec_mgr_update(struct work_struct *work)
> +{
> +	u32 size, blk_size, offset =3D 0;
> +	struct ifpga_sec_mgr *imgr;
> +	const struct firmware *fw;
> +	enum ifpga_sec_err ret;
> +
> +	imgr =3D container_of(work, struct ifpga_sec_mgr, work);
> +
> +	get_device(&imgr->dev);
> +	if (request_firmware(&fw, imgr->filename, &imgr->dev)) {
> +		imgr->err_code =3D IFPGA_SEC_ERR_FILE_READ;
> +		goto idle_exit;
> +	}
> +
> +	imgr->data =3D fw->data;
> +	imgr->remaining_size =3D fw->size;
> +
> +	if (!try_module_get(imgr->dev.parent->driver->owner)) {
> +		imgr->err_code =3D IFPGA_SEC_ERR_BUSY;
> +		goto release_fw_exit;
> +	}
> +
> +	imgr->progress =3D IFPGA_SEC_PROG_PREPARING;
> +	ret =3D imgr->iops->prepare(imgr);
> +	if (ret) {
> +		ifpga_sec_dev_error(imgr, ret);
> +		goto modput_exit;
> +	}
> +
> +	imgr->progress =3D IFPGA_SEC_PROG_WRITING;
> +	size =3D imgr->remaining_size;
> +	while (size) {
> +		blk_size =3D min_t(u32, size, WRITE_BLOCK_SIZE);
> +		size -=3D blk_size;
> +		ret =3D imgr->iops->write_blk(imgr, offset, blk_size);
> +		if (ret) {
> +			ifpga_sec_dev_error(imgr, ret);
> +			goto done;
> +		}
> +
> +		imgr->remaining_size =3D size;
> +		offset +=3D blk_size;
> +	}

Looks like we can remove size and just use remaining_size here?

> +
> +	imgr->progress =3D IFPGA_SEC_PROG_PROGRAMMING;
> +	ret =3D imgr->iops->poll_complete(imgr);
> +	if (ret) {
> +		ifpga_sec_dev_error(imgr, ret);
> +		goto done;

Looks like no need for this goto done.

> +	}
> +
> +done:
> +	if (imgr->iops->cleanup)
> +		imgr->iops->cleanup(imgr);
> +
> +modput_exit:
> +	module_put(imgr->dev.parent->driver->owner);
> +
> +release_fw_exit:
> +	imgr->data =3D NULL;
> +	release_firmware(fw);
> +
> +idle_exit:
> +	/*
> +	 * Note: imgr->remaining_size is left unmodified here to
> +	 * provide additional information on errors. It will be
> +	 * reinitialized when the next secure update begins.
> +	 */
> +	kfree(imgr->filename);
> +	imgr->filename =3D NULL;
> +	put_device(&imgr->dev);
> +	progress_complete(imgr);

Should it call this function progress complete even in failure case?
A little confusing.

> +}
> +
>  #define check_attr(attribute, _name) \
>  	((attribute) =3D=3D &dev_attr_##_name.attr && imgr->iops->_name)
>=20
> @@ -164,6 +259,48 @@ static struct attribute_group
> sec_mgr_security_attr_group =3D {
>  	.is_visible =3D sec_mgr_visible,
>  };
>=20
> +static ssize_t filename_store(struct device *dev, struct device_attribut=
e *attr,
> +			      const char *buf, size_t count)
> +{
> +	struct ifpga_sec_mgr *imgr =3D to_sec_mgr(dev);
> +	int ret =3D count;
> +
> +	if (count =3D=3D 0 || count >=3D PATH_MAX)
> +		return -EINVAL;
> +
> +	mutex_lock(&imgr->lock);
> +	if (imgr->driver_unload || imgr->progress !=3D IFPGA_SEC_PROG_IDLE)
> {
> +		ret =3D -EBUSY;
> +		goto unlock_exit;
> +	}
> +
> +	imgr->filename =3D kstrndup(buf, count - 1, GFP_KERNEL);
> +	if (!imgr->filename) {
> +		ret =3D -ENOMEM;
> +		goto unlock_exit;
> +	}
> +
> +	imgr->err_code =3D IFPGA_SEC_ERR_NONE;
> +	imgr->progress =3D IFPGA_SEC_PROG_READING;
> +	reinit_completion(&imgr->update_done);
> +	schedule_work(&imgr->work);
> +
> +unlock_exit:
> +	mutex_unlock(&imgr->lock);
> +	return ret;
> +}
> +static DEVICE_ATTR_WO(filename);
> +
> +static struct attribute *sec_mgr_update_attrs[] =3D {
> +	&dev_attr_filename.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group sec_mgr_update_attr_group =3D {
> +	.name =3D "update",
> +	.attrs =3D sec_mgr_update_attrs,
> +};
> +
>  static ssize_t name_show(struct device *dev,
>  			 struct device_attribute *attr, char *buf)
>  {
> @@ -185,6 +322,7 @@ static struct attribute_group sec_mgr_attr_group =3D =
{
>  static const struct attribute_group *ifpga_sec_mgr_attr_groups[] =3D {
>  	&sec_mgr_attr_group,
>  	&sec_mgr_security_attr_group,
> +	&sec_mgr_update_attr_group,
>  	NULL,
>  };
>=20
> @@ -245,6 +383,12 @@ ifpga_sec_mgr_create(struct device *dev, const char
> *name,
>  	struct ifpga_sec_mgr *imgr;
>  	int id, ret;
>=20
> +	if (!iops || !iops->cancel || !iops->prepare ||
> +	    !iops->write_blk || !iops->poll_complete) {
> +		dev_err(dev, "Attempt to register without required ops\n");
> +		return NULL;
> +	}
> +
>  	if (!check_reh_handler(dev, iops, bmc) ||
>  	    !check_reh_handler(dev, iops, sr) ||
>  	    !check_reh_handler(dev, iops, pr) ||
> @@ -272,6 +416,8 @@ ifpga_sec_mgr_create(struct device *dev, const char
> *name,
>  	imgr->name =3D name;
>  	imgr->priv =3D priv;
>  	imgr->iops =3D iops;
> +	init_completion(&imgr->update_done);
> +	INIT_WORK(&imgr->work, ifpga_sec_mgr_update);
>=20
>  	device_initialize(&imgr->dev);
>  	imgr->dev.class =3D ifpga_sec_mgr_class;
> @@ -397,6 +543,17 @@ void ifpga_sec_mgr_unregister(struct ifpga_sec_mgr
> *imgr)
>  {
>  	dev_info(&imgr->dev, "%s %s\n", __func__, imgr->name);
>=20
> +	mutex_lock(&imgr->lock);
> +	imgr->driver_unload =3D true;

May need some comments here, do you mean get module doesn't work here
to prevent unexpected driver unloading? Or you mean parent device maybe
hot unplug in some cases?

Thanks
Hao

> +	if (imgr->progress =3D=3D IFPGA_SEC_PROG_IDLE) {
> +		mutex_unlock(&imgr->lock);
> +		goto unregister;
> +	}
> +
> +	mutex_unlock(&imgr->lock);
> +	wait_for_completion(&imgr->update_done);
> +
> +unregister:
>  	device_unregister(&imgr->dev);
>  }
>  EXPORT_SYMBOL_GPL(ifpga_sec_mgr_unregister);
> diff --git a/include/linux/fpga/ifpga-sec-mgr.h b/include/linux/fpga/ifpg=
a-
> sec-mgr.h
> index ded62090e9b9..27008abd8e75 100644
> --- a/include/linux/fpga/ifpga-sec-mgr.h
> +++ b/include/linux/fpga/ifpga-sec-mgr.h
> @@ -7,12 +7,26 @@
>  #ifndef _LINUX_IFPGA_SEC_MGR_H
>  #define _LINUX_IFPGA_SEC_MGR_H
>=20
> +#include <linux/completion.h>
>  #include <linux/device.h>
>  #include <linux/mutex.h>
>  #include <linux/types.h>
>=20
>  struct ifpga_sec_mgr;
>=20
> +enum ifpga_sec_err {
> +	IFPGA_SEC_ERR_NONE,
> +	IFPGA_SEC_ERR_HW_ERROR,
> +	IFPGA_SEC_ERR_TIMEOUT,
> +	IFPGA_SEC_ERR_CANCELED,
> +	IFPGA_SEC_ERR_BUSY,
> +	IFPGA_SEC_ERR_INVALID_SIZE,
> +	IFPGA_SEC_ERR_RW_ERROR,
> +	IFPGA_SEC_ERR_WEAROUT,
> +	IFPGA_SEC_ERR_FILE_READ,
> +	IFPGA_SEC_ERR_MAX
> +};
> +
>  /**
>   * struct ifpga_sec_mgr_ops - device specific operations
>   * @user_flash_count:	    Optional: Return sysfs string output for FPGA
> @@ -35,6 +49,17 @@ struct ifpga_sec_mgr;
>   * @bmc_reh_size:	    Optional: Return byte size for BMC root entry hash
>   * @sr_reh_size:	    Optional: Return byte size for SR root entry hash
>   * @pr_reh_size:	    Optional: Return byte size for PR root entry hash
> + * @prepare:		    Required: Prepare secure update
> + * @write_blk:		    Required: Write a block of data
> + * @poll_complete:	    Required: Check for the completion of the
> + *			    HW authentication/programming process. This
> + *			    function should check for imgr->driver_unload
> + *			    and abort with IFPGA_SEC_ERR_CANCELED when
> true.
> + * @cancel:		    Required: Signal HW to cancel update
> + * @cleanup:		    Optional: Complements the prepare()
> + *			    function and is called at the completion
> + *			    of the update, whether success or failure,
> + *			    if the prepare function succeeded.
>   */
>  struct ifpga_sec_mgr_ops {
>  	int (*user_flash_count)(struct ifpga_sec_mgr *imgr);
> @@ -56,6 +81,22 @@ struct ifpga_sec_mgr_ops {
>  	int (*bmc_canceled_csk_nbits)(struct ifpga_sec_mgr *imgr);
>  	int (*sr_canceled_csk_nbits)(struct ifpga_sec_mgr *imgr);
>  	int (*pr_canceled_csk_nbits)(struct ifpga_sec_mgr *imgr);
> +	enum ifpga_sec_err (*prepare)(struct ifpga_sec_mgr *imgr);
> +	enum ifpga_sec_err (*write_blk)(struct ifpga_sec_mgr *imgr,
> +					u32 offset, u32 size);
> +	enum ifpga_sec_err (*poll_complete)(struct ifpga_sec_mgr *imgr);
> +	void (*cleanup)(struct ifpga_sec_mgr *imgr);
> +	enum ifpga_sec_err (*cancel)(struct ifpga_sec_mgr *imgr);
> +};
> +
> +/* Update progress codes */
> +enum ifpga_sec_prog {
> +	IFPGA_SEC_PROG_IDLE,
> +	IFPGA_SEC_PROG_READING,
> +	IFPGA_SEC_PROG_PREPARING,
> +	IFPGA_SEC_PROG_WRITING,
> +	IFPGA_SEC_PROG_PROGRAMMING,
> +	IFPGA_SEC_PROG_MAX
>  };
>=20
>  struct ifpga_sec_mgr {
> @@ -63,6 +104,14 @@ struct ifpga_sec_mgr {
>  	struct device dev;
>  	const struct ifpga_sec_mgr_ops *iops;
>  	struct mutex lock;		/* protect data structure contents */
> +	struct work_struct work;
> +	struct completion update_done;
> +	char *filename;
> +	const u8 *data;			/* pointer to update data */
> +	u32 remaining_size;		/* size remaining to transfer */
> +	enum ifpga_sec_prog progress;
> +	enum ifpga_sec_err err_code;	/* security manager error code */
> +	bool driver_unload;
>  	void *priv;
>  };
>=20
> --
> 2.17.1

