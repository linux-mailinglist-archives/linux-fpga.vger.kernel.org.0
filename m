Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7848828329B
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Oct 2020 10:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgJEIz0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Oct 2020 04:55:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:20833 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgJEIz0 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 5 Oct 2020 04:55:26 -0400
IronPort-SDR: hekEotWoecDri7yg0KpHznYYPlGrOS+w/WIgKq944AysKpUSmLL2NsVjKjT9Zbp8JeyW/Asxpu
 dfUXYyRvVNSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9764"; a="227493761"
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="227493761"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 01:55:23 -0700
IronPort-SDR: lUN3Zjty0K9je+t0cfxYzGEBCtsbZKzESb4c67DQ5a0+xZjFawIeFocGwAFY6n08jCPBikOZiF
 93nmG+zF7u4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="296027635"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 05 Oct 2020 01:55:23 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 5 Oct 2020 01:55:23 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 5 Oct 2020 01:55:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 5 Oct 2020 01:55:22 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 5 Oct 2020 01:55:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOWUjY2JAs0cKoYsoqIBarcpajRow4R7UwyUj131iD1XjncJMHJizbPTOa+H8A0LpzsjtyBLpDSJDcNm64L8BzTxkYFI9dci5H6f96GJ1mVoTDXCOYvgPQKLLF3LYElmV3C6+UCfTiSrX0VLoBgH/r0ENBfjR3h1sHy6Ys1ilnGxAkj7sezf/gOOHzpxxgzW0Mi33b9LUG5W8YuH9Pn8u6zyzvdgut4nFJodSUC8P9kiJH9EF3jCmLTEqL575eCGWhAW2pQReGmMTbviSKJcaVub3cL10OpAUXs7Un8tqmfsZCjX9CWEHQj24LFIlfN8vNVEN8BPad0W3oPWwMvvGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITw6qcQQBVLxQ78kOuo8Q5K4ABjnW9QOFLK9Df9VVz0=;
 b=LOsrQPABXDELEFljX7aXcP2mfsi37SHdL7PF2F2RvF/UPtYbPC3HULvcmYY0pYX/R7IE6YqmfV7NFXfT97obC/jqr6Dy/l5jyC4N6AGBZNNjMECnNRgQ7OeSXpE/SAohJB8aSUa4BVIRudImshjEtZm+MkxdBgOUumTx/Rv9ZgBj36WIt06R7Tbh/f6iu8zXT+8COflNDUm2L2epEoEqrtfikH8shwpzxae1oncYbtkggaxmzDBbEIy2wp3v6bZ2Ne6qsjnklFpxHjISICpfvxkBBb2QSj+dNVO143eFVtoXKrZ0p28QCAYxUXpQfwxDJtx+Oiug252H2OqpqJbreQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITw6qcQQBVLxQ78kOuo8Q5K4ABjnW9QOFLK9Df9VVz0=;
 b=gIRfzdatTRnKoJ2zKdWhT2yicUJcFWdTd4bC2+LF/8cHv1K9L6qT2Tm4ST4L39dQbP9Zf2RevNuGdeEMqGkFC8WbxmNwVzTQlQ+hOHSGjcMXVgg24jQkQIYDqYaZV0gCDHUudENpt2vbxl6gDDdtJ7KF5z5EMwsq3vUK6kbzfZg=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB4267.namprd11.prod.outlook.com (2603:10b6:5:14e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Mon, 5 Oct
 2020 08:55:16 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::8daf:2295:b5df:2c7e]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::8daf:2295:b5df:2c7e%3]) with mapi id 15.20.3433.043; Mon, 5 Oct 2020
 08:55:16 +0000
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
Subject: RE: [PATCH v2 4/7] fpga: sec-mgr: expose sec-mgr update errors
Thread-Topic: [PATCH v2 4/7] fpga: sec-mgr: expose sec-mgr update errors
Thread-Index: AQHWmQydMqNYMQIj+0GcvvC6EateLqmIt1VA
Date:   Mon, 5 Oct 2020 08:55:16 +0000
Message-ID: <DM6PR11MB3819F5AF4275019A8F0D3208850C0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20201002223701.1317-1-russell.h.weight@intel.com>
 <20201002223701.1317-5-russell.h.weight@intel.com>
In-Reply-To: <20201002223701.1317-5-russell.h.weight@intel.com>
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
x-ms-office365-filtering-correlation-id: 76125f6b-a0e7-4194-257b-08d8690c6135
x-ms-traffictypediagnostic: DM6PR11MB4267:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB42672E9DC53064C3BB87A052850C0@DM6PR11MB4267.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9vOvWcmfR2cz/d5JKg+UrFjQ77eNeWcXD4kz5yYSftLYLdpDOyRKo4p1rZIqxVbLYGbUyFRbL1ZdqXXJBKhPDoPsORYDvCCB2JQairQ4EPR4B0g1g4W24xTin3IfHdFX/FfG4Omkj/+ipgmtnH9tVqT4BzK/royWE0rqE2B5uXBskfmKHDUtv7bkGCq1kNJgWrkHdXgpmlG7mNXFbNmp7bYdgeZYBNstgfafocEMAb1YjU0NLbEYN11MnHubAtU6sKyIralUNHdrUWx7R3TXF+gZKfVFPkvwugzo1zvac6t5EzsGs/IsfE1euRNqKBIR7vsQBLjsJmeazjsp/AwKOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(52536014)(15650500001)(55016002)(66476007)(9686003)(8936002)(8676002)(2906002)(54906003)(110136005)(107886003)(66946007)(316002)(4326008)(83380400001)(5660300002)(478600001)(33656002)(6506007)(7696005)(66446008)(86362001)(26005)(76116006)(186003)(64756008)(66556008)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: fF1UluZYhR64C+v9AOnc9l+mjk84VGAEvJ80Jz6tfwcx1GUraU2+ERnflPZEqV75ar8EC6xQwmLdZ+UMNVdNvaVJP10qjfHt818foDKTyJWhRDmvtuCFYA88olvCIXcO8yI/XzHPYmFKQsSGkwzVkXGZjjSWzbJCyKFf9JwaqBrZ2yY1ipN5azndI26nO0yaEfx5kSGhFfUStcb5gysbaKBEZmgT25zhF4MYZGy/MH/dRmEzrZaa6PI5rOL8L6M9Yvr9E0/c4O+bR80RBJ/5tz2s624zirWyW9ubb0NOXJ2HdSzTaeoohQJMuUcxbuyVC7kRmVkBCKPkWFvGzNpUVXTDUzxCuS5czCzDgAViGXyTT/Gm4oXOvrWRJYH6HjdVWV6LNrqh/FddUFyw0XMuuuqMX9tvQk8qq38K7EIVWlkNpQ5L9xVr1vcU9UGC6F6KB1ckMJo5tyxbZspW+eK4vCwy7PzbjLLlrRguw0s2ixJjvAXM282omrY0bHQN+vktAybpkBIJ8HVvQOjcobHj2JHlbnaiyqgeLVaAQQIKk8UJYkFIwv6sjFxAdznUb0bsgYV904qes8uDVM/uWTc1g9+0x0PlYGqNI8xSQE5CjIvRj/80xppovb5wgTD/z26eMeMQchesQVu+tKwPJwpgRA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76125f6b-a0e7-4194-257b-08d8690c6135
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2020 08:55:16.3172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q4uwGbt6tISEPFrnP0xFG0YCCngeJLzDlz9ZiO4Qjpb01GMVEer42TkfbsCfiSZoaXgdC6xTathXMQDZ5U9hyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4267
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v2 4/7] fpga: sec-mgr: expose sec-mgr update errors
>=20
> Extend Intel Security Manager class driver to include
> an update/error sysfs node that can be read for error
> information when a secure update fails.
>=20
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v2:
>   - Bumped documentation date and version
>   - Added warning to sec_progress() for invalid progress status
>   - Added sec_error() function (similar to sec_progress())
> ---
>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 17 ++++
>  drivers/fpga/ifpga-sec-mgr.c                  | 81 ++++++++++++++++---
>  include/linux/fpga/ifpga-sec-mgr.h            |  1 +
>  3 files changed, 89 insertions(+), 10 deletions(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> index 73a5246fea1b..1f9f2c215e0c 100644
> --- a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> +++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> @@ -89,3 +89,20 @@ Description:	Read-only. Returns a string describing
> the current
>  		programming. Userspace code can poll on this file,
>  		as it will be signaled by sysfs_notify() on each
>  		state change.
> +
> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/error
> +Date:		Oct 2020
> +KernelVersion:  5.11
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read-only. Returns a string describing the failure
> +		of a secure update. This string will be in the form
> +		of <STATUS>:<ERROR>, where <STATUS> will be one of
> +		the status strings described for the status sysfs
> +		file and <ERROR> will be one of the following:
> +		hw-error, timeout, user-abort, device-busy,
> +		invalid-file-size, read-write-error, flash-wearout,
> +		file-read-error.  The error sysfs file is only
> +		meaningful when the secure update engine is in the
> +		idle state. If this file is read while a secure
> +		update is in progress, then the read will fail with
> +		EBUSY.
> diff --git a/drivers/fpga/ifpga-sec-mgr.c b/drivers/fpga/ifpga-sec-mgr.c
> index ad918fb42dc2..456ea0b71e3d 100644
> --- a/drivers/fpga/ifpga-sec-mgr.c
> +++ b/drivers/fpga/ifpga-sec-mgr.c
> @@ -146,10 +146,16 @@ static void update_progress(struct ifpga_sec_mgr
> *imgr,
>  	sysfs_notify(&imgr->dev.kobj, "update", "status");
>  }
>=20
> +static void set_error(struct ifpga_sec_mgr *imgr, enum ifpga_sec_err
> err_code)
> +{
> +	imgr->err_state =3D imgr->progress;
> +	imgr->err_code =3D err_code;
> +}
> +
>  static void ifpga_sec_dev_error(struct ifpga_sec_mgr *imgr,
>  				enum ifpga_sec_err err_code)
>  {
> -	imgr->err_code =3D err_code;
> +	set_error(imgr, err_code);
>  	imgr->iops->cancel(imgr);
>  }
>=20
> @@ -172,7 +178,7 @@ static void ifpga_sec_mgr_update(struct work_struct
> *work)
>=20
>  	get_device(&imgr->dev);
>  	if (request_firmware(&fw, imgr->filename, &imgr->dev)) {
> -		imgr->err_code =3D IFPGA_SEC_ERR_FILE_READ;
> +		set_error(imgr, IFPGA_SEC_ERR_FILE_READ);
>  		goto idle_exit;
>  	}
>=20
> @@ -180,7 +186,7 @@ static void ifpga_sec_mgr_update(struct work_struct
> *work)
>  	imgr->remaining_size =3D fw->size;
>=20
>  	if (!try_module_get(imgr->dev.parent->driver->owner)) {
> -		imgr->err_code =3D IFPGA_SEC_ERR_BUSY;
> +		set_error(imgr, IFPGA_SEC_ERR_BUSY);
>  		goto release_fw_exit;
>  	}
>=20
> @@ -274,22 +280,76 @@ static const char * const sec_mgr_prog_str[] =3D {
>  	"programming"		/* IFPGA_SEC_PROG_PROGRAMMING */
>  };
>=20
> -static ssize_t
> -status_show(struct device *dev, struct device_attribute *attr, char *buf=
)
> +static const char * const sec_mgr_err_str[] =3D {
> +	"none",			/* IFPGA_SEC_ERR_NONE */
> +	"hw-error",		/* IFPGA_SEC_ERR_HW_ERROR */
> +	"timeout",		/* IFPGA_SEC_ERR_TIMEOUT */
> +	"user-abort",		/* IFPGA_SEC_ERR_CANCELED */
> +	"device-busy",		/* IFPGA_SEC_ERR_BUSY */
> +	"invalid-file-size",	/* IFPGA_SEC_ERR_INVALID_SIZE */
> +	"read-write-error",	/* IFPGA_SEC_ERR_RW_ERROR */
> +	"flash-wearout",	/* IFPGA_SEC_ERR_WEAROUT */
> +	"file-read-error"	/* IFPGA_SEC_ERR_FILE_READ */
> +};
> +
> +static const char *sec_progress(struct device *dev, enum ifpga_sec_prog
> prog)
>  {
> -	struct ifpga_sec_mgr *imgr =3D to_sec_mgr(dev);
>  	const char *status =3D "unknown-status";
>=20
> -	if (imgr->progress < IFPGA_SEC_PROG_MAX)
> -		status =3D sec_mgr_prog_str[imgr->progress];
> +	if (prog < IFPGA_SEC_PROG_MAX)
> +		status =3D sec_mgr_prog_str[prog];
>  	else
>  		dev_warn(dev, "Invalid status during secure update: %d\n",
> -			 imgr->progress);
> +			 prog);
> +
> +	return status;
> +}
> +
> +static const char *sec_error(struct device *dev, enum ifpga_sec_err
> err_code)
> +{
> +	const char *error =3D "unknown-error";
> +
> +	if (err_code < IFPGA_SEC_ERR_MAX)
> +		error =3D sec_mgr_err_str[err_code];
> +	else
> +		dev_warn(dev, "Invalid error code during secure
> update: %d\n",
> +			 err_code);
> +
> +	return error;
> +}
> +
> +static ssize_t
> +status_show(struct device *dev, struct device_attribute *attr, char *buf=
)
> +{
> +	struct ifpga_sec_mgr *imgr =3D to_sec_mgr(dev);
>=20
> -	return sprintf(buf, "%s\n", status);
> +	return sprintf(buf, "%s\n", sec_progress(dev, imgr->progress));
>  }
>  static DEVICE_ATTR_RO(status);
>=20
> +static ssize_t
> +error_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct ifpga_sec_mgr *imgr =3D to_sec_mgr(dev);
> +	int ret;
> +
> +	mutex_lock(&imgr->lock);
> +
> +	if (imgr->progress !=3D IFPGA_SEC_PROG_IDLE)
> +		ret =3D -EBUSY;
> +	else if (!imgr->err_code)
> +		ret =3D 0;
> +	else
> +		ret =3D sprintf(buf, "%s:%s\n",
> +			      sec_progress(dev, imgr->err_state),
> +			      sec_error(dev, imgr->err_code));

In scheduled work for update, there is no lock protection, would that be a=
=20
real problem here? e.g. progress is changed, or err_state and err_code
are not matched.

Thanks
Hao

> +
> +	mutex_unlock(&imgr->lock);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(error);
> +
>  static ssize_t filename_store(struct device *dev, struct device_attribut=
e *attr,
>  			      const char *buf, size_t count)
>  {
> @@ -325,6 +385,7 @@ static DEVICE_ATTR_WO(filename);
>  static struct attribute *sec_mgr_update_attrs[] =3D {
>  	&dev_attr_filename.attr,
>  	&dev_attr_status.attr,
> +	&dev_attr_error.attr,
>  	NULL,
>  };
>=20
> diff --git a/include/linux/fpga/ifpga-sec-mgr.h b/include/linux/fpga/ifpg=
a-
> sec-mgr.h
> index 27008abd8e75..246e3d452c59 100644
> --- a/include/linux/fpga/ifpga-sec-mgr.h
> +++ b/include/linux/fpga/ifpga-sec-mgr.h
> @@ -110,6 +110,7 @@ struct ifpga_sec_mgr {
>  	const u8 *data;			/* pointer to update data */
>  	u32 remaining_size;		/* size remaining to transfer */
>  	enum ifpga_sec_prog progress;
> +	enum ifpga_sec_prog err_state;	/* progress state at time of
> failure */
>  	enum ifpga_sec_err err_code;	/* security manager error code */
>  	bool driver_unload;
>  	void *priv;
> --
> 2.17.1

