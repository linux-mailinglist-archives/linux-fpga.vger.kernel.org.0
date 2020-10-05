Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49943283255
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Oct 2020 10:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgJEImK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Oct 2020 04:42:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:5130 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgJEImJ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 5 Oct 2020 04:42:09 -0400
IronPort-SDR: 77nHAJi6ErPVOdBtkJs4Z7WK4BqIz3d+FGIlQZgxqtg1yShg9/SdTDgLXbOUQXoSUsao3mioRG
 eMCQfvkCsIFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9764"; a="143345944"
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="143345944"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 01:42:01 -0700
IronPort-SDR: ZG8ylleAlY9jDYGEo25e+i33ZrYOzDyxkF1bpTsX9tyka89XB9VmWsNxTcd3IsutQnwVhPVZ1E
 7Py0h21TPdTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="296024911"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 05 Oct 2020 01:42:00 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 5 Oct 2020 01:42:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 5 Oct 2020 01:42:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 5 Oct 2020 01:41:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dql3z0O3AHpyfmmEWu7rD+q2HvNMEPJ24IrdGMcRy1C+RiemNbZLed20pNiuLZkyhlZd55BlrZ9xrUT1r+MZfLt5BIs3B6a4rcd40KPS/uFo1ktPt/8fsbUrAUCBzdvU9itRK3N3gri7/WDGnJlVvHwV3pArx9Gu6q8PWohDOzLJbl0jjnhaQf4qB8ul0s5TNfSbU70PodvmbaF82ZQ4t1fqvMq95FW5qLJ4j9MiMerJtV1Y/VjjMq72AdNFdRyj4ZV7czNb7ynOo8BHYbTKtQH69allRcm4DlyIlY1QYtFdJEt+M8cNhuMHV4PklHrN5N5t4IRcm4Gj8+hrvSzLpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4vFnVpZexIivgH8VQlH2a03CxHBNy/n8IAysNqyEC4=;
 b=RumFpFMnOXOuPfN+PHQY0IDItzJvhFKP5iNiCkEPhsFWI6oooCmdpi41UtWZTP19aGDA4NTaMjv71+n+6wD0Q03/G2XG2rv5uUa1N9RaLuCxGDWCggMPGN6Yk0J8ph3/C3clbv/xX3T7oXXK5507wHeIOr4kpn4eUIzKuXzFcKpr2shs/xw89UEx6LFb/Ko9PnHJGO0+4l3xoB02g9i9Nlf/ojSNen6xoAv6Umah4HyQK9ttBsN9ozfseNSbFR7Gm9skuEvd1YNQ09JAu7IbFr7XQlL/a7INpTTmScMGJCAYI9Ee6jBCmsPaSY6uLTIZ43uWXU1/dazQ+mcoGFHvag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4vFnVpZexIivgH8VQlH2a03CxHBNy/n8IAysNqyEC4=;
 b=w2lCrIGLpm+SOpY9LlHSj+JMzUdxfZm39ibTxrA0IWYu4j747MA60LuPQGPBd0nmcZdKDxS2HxfgRithh01ameLkO5mOgfY6Yqydmrw4gnEZPhN/kRl83v7AIL/1mv4KzhWVTYuej/DdJ1JdYBa1Y565LQFcPsL3vHA43BTwftA=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB4267.namprd11.prod.outlook.com (2603:10b6:5:14e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Mon, 5 Oct
 2020 08:41:57 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::8daf:2295:b5df:2c7e]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::8daf:2295:b5df:2c7e%3]) with mapi id 15.20.3433.043; Mon, 5 Oct 2020
 08:41:57 +0000
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
Subject: RE: [PATCH v2 3/7] fpga: sec-mgr: expose sec-mgr update status
Thread-Topic: [PATCH v2 3/7] fpga: sec-mgr: expose sec-mgr update status
Thread-Index: AQHWmQ/RnWsCwCvAjkibUDvEcUUXCamIsmlA
Date:   Mon, 5 Oct 2020 08:41:56 +0000
Message-ID: <DM6PR11MB3819276C0C4F12E3CEF33F3E850C0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20201002223701.1317-1-russell.h.weight@intel.com>
 <20201002223701.1317-4-russell.h.weight@intel.com>
In-Reply-To: <20201002223701.1317-4-russell.h.weight@intel.com>
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
x-ms-office365-filtering-correlation-id: 1823b0b3-15e2-42ca-9e5a-08d8690a84b7
x-ms-traffictypediagnostic: DM6PR11MB4267:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4267176B2B1B5CBFD3F54E76850C0@DM6PR11MB4267.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BtYvQMlRLNaDVvnf/9EeszEzd78iWXYU6siLg9vFmGyj1vmr8R/OQCjwUTKk6fv5syewDW8omtN0gspZS6HdjCsSoDl3ZwrjBv2m5QDIHicX/teRe4Pozi5Rekfpfh03CzTPpviBYaluDmJhd+E9dDr1CY4xRriTBEcwSRNIw9SWP0tub5VrUrSdBA6CH6F7gCEHwq5cWEsE+LzFIEtFFJ2MCXlAo8kV6Mq8JOirL8zt2yDpQC5k+hrt+MvqNGEZtw7h2EwCKvrZoeboZ+3E5kUAAsf6F7p6HkJgSpHZcz4ZBXZoJT8WSr7suGuKP6EPHEYK7ppKOSNWRzHODnN+YA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(52536014)(15650500001)(55016002)(66476007)(9686003)(8936002)(8676002)(2906002)(54906003)(110136005)(107886003)(66946007)(316002)(4326008)(83380400001)(5660300002)(478600001)(33656002)(6506007)(7696005)(66446008)(86362001)(26005)(76116006)(186003)(64756008)(66556008)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Av7fDC+7v3TVvwWkbIQfHwNVdFOv3kyyFMpSsTLJjtrHDZdJcP4Tz9qIX6kST/7ye247+HNpQpSLPuNhmbUBD7AW/LrtFrlofAQzaxVM6WdyLq0rTRVRRWRUmLC0nKTjBPcotruhAiMSox3gp57drG3iUau2MP/EKrOp7XpcGschkOLd7O60UJ9SklMyP5rg+MjAJ++YZm7DbNez9hxFpM0G5y35lGSzv02QGudsgPv7hAGUuJQSlUFDF0L6Fv09U04+DYkoyeMZdH/70f1/Q7YQaODqSKM5O2KEFriAp1Q3dM6KFTREJI7Y4JewbOIn7Uqc+UY/W5oDDs2pANAexzaNteqVofUpomXeBU4L0cMnfQXyzn+jetoiC27rtzlrBwBe0feMoTBjROYGSKJ9NuE6gytPTe1HI7hbh6WlAAuBwiNtuM+MjbMVp8j/xBasIjR3fuWFaSpWKgIIWjcqP/UgzmPbgRU+s0zM9pEPgfIflI5msxy+y0MlT+RNVhVgeJL31YYv/RnriclY5CN8zwfaD1bqQ7tfEsACxZ0+r0LV+i5dIJLD8H8qOXC4SYyP9MVgfX49E3qehvyaenK2ylk9sEDbZHtwjCx6/TC2zZR5FB/Emu6NQ/dRknKPD0EuwqMoIywhEObCxm6S9c2mLw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1823b0b3-15e2-42ca-9e5a-08d8690a84b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2020 08:41:56.8651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gMMD1M+D9DwNE5foQ3/Hq20CrXw+Ydhe3jiMwL85SqGuCx+6WrnKTqfXEXRJ48K7+V9VdjaerGCJ+iaw4WQJyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4267
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v2 3/7] fpga: sec-mgr: expose sec-mgr update status
>=20
> Extend the Intel Security Manager class driver to
> include an update/status sysfs node that can be polled
> and read to monitor the progress of an ongoing secure
> update. Sysfs_notify() is used to signal transitions
> between different phases of the update process.
>=20
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v2:
>   - Bumped documentation date and version
>   - Changed progress state "read_file" to "reading"
> ---
>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 11 +++++
>  drivers/fpga/ifpga-sec-mgr.c                  | 40 +++++++++++++++++--
>  2 files changed, 47 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> index 4f375f132c34..73a5246fea1b 100644
> --- a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> +++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> @@ -78,3 +78,14 @@ Description:	Write only. Write the filename of an
> Intel image
>  		BMC images, BMC firmware, Static Region images,
>  		and Root Entry Hashes, and to cancel Code Signing
>  		Keys (CSK).
> +
> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/status
> +Date:		Oct 2020
> +KernelVersion:  5.11
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read-only. Returns a string describing the current
> +		status of an update. The string will be one of the
> +		following: idle, reading, preparing, writing,
> +		programming. Userspace code can poll on this file,
> +		as it will be signaled by sysfs_notify() on each
> +		state change.
> diff --git a/drivers/fpga/ifpga-sec-mgr.c b/drivers/fpga/ifpga-sec-mgr.c
> index 7d5a4979554b..ad918fb42dc2 100644
> --- a/drivers/fpga/ifpga-sec-mgr.c
> +++ b/drivers/fpga/ifpga-sec-mgr.c
> @@ -139,6 +139,13 @@ static struct attribute *sec_mgr_security_attrs[] =
=3D {
>  	NULL,
>  };
>=20
> +static void update_progress(struct ifpga_sec_mgr *imgr,
> +			    enum ifpga_sec_prog new_progress)
> +{
> +	imgr->progress =3D new_progress;
> +	sysfs_notify(&imgr->dev.kobj, "update", "status");
> +}
> +
>  static void ifpga_sec_dev_error(struct ifpga_sec_mgr *imgr,
>  				enum ifpga_sec_err err_code)
>  {
> @@ -149,7 +156,7 @@ static void ifpga_sec_dev_error(struct ifpga_sec_mgr
> *imgr,
>  static void progress_complete(struct ifpga_sec_mgr *imgr)
>  {
>  	mutex_lock(&imgr->lock);
> -	imgr->progress =3D IFPGA_SEC_PROG_IDLE;
> +	update_progress(imgr, IFPGA_SEC_PROG_IDLE);
>  	complete_all(&imgr->update_done);
>  	mutex_unlock(&imgr->lock);
>  }
> @@ -177,14 +184,14 @@ static void ifpga_sec_mgr_update(struct
> work_struct *work)
>  		goto release_fw_exit;
>  	}
>=20
> -	imgr->progress =3D IFPGA_SEC_PROG_PREPARING;
> +	update_progress(imgr, IFPGA_SEC_PROG_PREPARING);
>  	ret =3D imgr->iops->prepare(imgr);
>  	if (ret) {
>  		ifpga_sec_dev_error(imgr, ret);
>  		goto modput_exit;
>  	}
>=20
> -	imgr->progress =3D IFPGA_SEC_PROG_WRITING;
> +	update_progress(imgr, IFPGA_SEC_PROG_WRITING);
>  	size =3D imgr->remaining_size;
>  	while (size) {
>  		blk_size =3D min_t(u32, size, WRITE_BLOCK_SIZE);
> @@ -199,7 +206,7 @@ static void ifpga_sec_mgr_update(struct work_struct
> *work)
>  		offset +=3D blk_size;
>  	}
>=20
> -	imgr->progress =3D IFPGA_SEC_PROG_PROGRAMMING;
> +	update_progress(imgr, IFPGA_SEC_PROG_PROGRAMMING);
>  	ret =3D imgr->iops->poll_complete(imgr);
>  	if (ret) {
>  		ifpga_sec_dev_error(imgr, ret);
> @@ -259,6 +266,30 @@ static struct attribute_group
> sec_mgr_security_attr_group =3D {
>  	.is_visible =3D sec_mgr_visible,
>  };
>=20
> +static const char * const sec_mgr_prog_str[] =3D {
> +	"idle",			/* IFPGA_SEC_PROG_IDLE */
> +	"reading",		/* IFPGA_SEC_PROG_READING */
> +	"preparing",		/* IFPGA_SEC_PROG_PREPARING */
> +	"writing",		/* IFPGA_SEC_PROG_WRITING */
> +	"programming"		/* IFPGA_SEC_PROG_PROGRAMMING */
> +};
> +
> +static ssize_t
> +status_show(struct device *dev, struct device_attribute *attr, char *buf=
)
> +{
> +	struct ifpga_sec_mgr *imgr =3D to_sec_mgr(dev);
> +	const char *status =3D "unknown-status";
> +
> +	if (imgr->progress < IFPGA_SEC_PROG_MAX)
> +		status =3D sec_mgr_prog_str[imgr->progress];

I am not sure if this would be a problem that as there is no lock protectio=
n for
the progress value. If someone changes imgr->progress into a bad value just
after the first check imgr->progress < IFPGA_SEC_PROG_MAX passed.

> +	else
> +		dev_warn(dev, "Invalid status during secure update: %d\n",
> +			 imgr->progress);

One minor thing, dev_err or even WARN_ON should be better, and I think=20
if it hits this, that will be a critical issue in the driver, isn't it?

Thanks
Hao

> +
> +	return sprintf(buf, "%s\n", status);
> +}
> +static DEVICE_ATTR_RO(status);
> +
>  static ssize_t filename_store(struct device *dev, struct device_attribut=
e *attr,
>  			      const char *buf, size_t count)
>  {
> @@ -293,6 +324,7 @@ static DEVICE_ATTR_WO(filename);
>=20
>  static struct attribute *sec_mgr_update_attrs[] =3D {
>  	&dev_attr_filename.attr,
> +	&dev_attr_status.attr,
>  	NULL,
>  };
>=20
> --
> 2.17.1

