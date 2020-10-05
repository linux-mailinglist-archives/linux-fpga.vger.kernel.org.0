Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973832830F9
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Oct 2020 09:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgJEHiW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Oct 2020 03:38:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:31852 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgJEHiW (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 5 Oct 2020 03:38:22 -0400
IronPort-SDR: KeSPQjgw9N4sC49j6IYS/MWg2Oh0QuJZ0PvrrQRjxOlYWbHcPYqDhw22TgBxheKieSZhBvayUu
 0OBONyppio1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9764"; a="151131557"
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="151131557"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 00:38:14 -0700
IronPort-SDR: SaRQIvRCNZBWjvtE9MvtAC4clGkFGjHweIrC7qk8qK2oXDttqeuvR0rTNqQrWUXYkvFTjpZwyQ
 MJbH/kLlGO8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="459385405"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 05 Oct 2020 00:38:14 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 5 Oct 2020 00:38:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 5 Oct 2020 00:38:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 5 Oct 2020 00:38:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdoel7d5dieQ9YBBanmPKqlgFjfPDzCF9KnYbgjJr4qn+7eFxOXufpaswWPs9UMSDyELUYjLpeFISks4en5bhdnRLqcY+9Z+HcGAOJwEy0wtVt/ko3uLz+ZfsklG3SMTOXCM4V08UlnDwQdmAxvdERR4d+u0qtYis5uTOCx68j7Xcc82Op5TBezGAQJmHA2otulZpBflEeytDX3KeedOns6uv+z9Gc2h/nTivFUc5Twbjll9RqleujvuY7UGwRm6yXFJGHQa10V+dC++Q5DQnlcbgcpgG/OrukaFEro3Cwf9pLWDcY/O9UO0UZj+iqXOuSa89L03O/3SVS3nQ3hPmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYOx9ubnWuVKA3iXoIb6Rpqy43mmaVQNTiMS8UvmnxA=;
 b=n4gHProd4y1FPiHzNnpDC41g5rHlwTmVmpRNyesMw6IMANf6djnWfxHQcFCWhK5bqV+0G1mO00qwf0YZVoTkO87cqKpH6ZzUYW+NecYds777l46C626SLx9aIHNMXycn4vvLKNLEQGPnjoPsxAIWELIND1BQ/ZrP+UhoQdBMRUyB5GcqOJcQudgX4gW6XJPwZmVyJRD5hZXtpI/QhM3v3+9mdKRsch/HAM7V338hgNNeXjAvzY+cGT8n0RbvpfeQZ4tsQsn1WJxM0h2z5ldU4rWcaOxKjvWAa8xStBgOvOGYBM+BUEBRgSt1DbM5z+MDfYrpx4gsNr8JJ+hGF0hurg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYOx9ubnWuVKA3iXoIb6Rpqy43mmaVQNTiMS8UvmnxA=;
 b=cmd/jHhWdMq050kaC7hhlgH9Y3lNY1Jbp7mPPtLy0lhV7RaVavb4YfvM20IIn8mxSZ2G0BT6t8+rTiWh2lClPhNwg6hnLJsDfMJsb+O0Ljih6PVyHxvwKEwAMrt23wY8vAszXa4ZwnDjApmcazjHUqaJl6DBLDhaArjvO5yNjzY=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3180.namprd11.prod.outlook.com (2603:10b6:5:9::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32; Mon, 5 Oct 2020 07:38:02 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::8daf:2295:b5df:2c7e]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::8daf:2295:b5df:2c7e%3]) with mapi id 15.20.3433.043; Mon, 5 Oct 2020
 07:38:02 +0000
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
Subject: RE: [PATCH v2 1/7] fpga: sec-mgr: intel fpga security manager class
 driver
Thread-Topic: [PATCH v2 1/7] fpga: sec-mgr: intel fpga security manager class
 driver
Thread-Index: AQHWmQyjgR1pLBSE7kmBJcXWBP2gwqmImoqA
Date:   Mon, 5 Oct 2020 07:38:02 +0000
Message-ID: <DM6PR11MB3819C847F595DD614ACD8AAF850C0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20201002223701.1317-1-russell.h.weight@intel.com>
 <20201002223701.1317-2-russell.h.weight@intel.com>
In-Reply-To: <20201002223701.1317-2-russell.h.weight@intel.com>
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
x-ms-office365-filtering-correlation-id: 77b540fe-4505-4cc4-8f11-08d869019754
x-ms-traffictypediagnostic: DM6PR11MB3180:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3180F8272D5C4C197A50B884850C0@DM6PR11MB3180.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:525;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N7lX+pnZi9LsNWMSGEo16EYmHN3DrsaE6/uzkqkHCBsm3HyOTCl7OL5esXNoV7IML3Nahr6L4Hb+q4LD53DKH8RMPlAUyJXMtpYFWMeU/isbPQD+9uNTTMZubEyJUp6C260x1Pm2EhkZh8+b+1Hb8CNZY1zhDxvsIzvHNg+xZVx4wuyhvhh4EYx6DOW1InpuKkmtckEIEOgNS/9pj3a7vV5aWMVkaxNfrh4/aZCvNA3E/Bi917BCfa35TrAYxLb/DaQFgSKaeZg066r70L9JXEJ8FXORW4zu01fhXQ8bdCUgKuNTvd6DVt5pVAbU2N+nDk0urXWafHBGUPgks37LPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(55016002)(15650500001)(478600001)(186003)(86362001)(30864003)(76116006)(33656002)(52536014)(7696005)(66946007)(66446008)(64756008)(66556008)(66476007)(5660300002)(107886003)(9686003)(83380400001)(8936002)(6506007)(8676002)(4326008)(110136005)(26005)(54906003)(2906002)(316002)(71200400001)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: dsQV7/NdF5opVPcRwn0aB7uPbGQ9TFddbCIEHy1iNDrxTp7Yteeh0CF3Je0N5jbYeKfDZHSDo49SBqhXClRNANXsUMKUkQWO7oGi7ieEKFkiQYVCCpxuLRsj9ckzjkXr4Jr4rw8fC1E3bzmmSD9/9I/dmw9wRLZbz83/+FLA0oaMPMzeEJCaM0CwO767M0fH9j73Zrm1TavhCVpl6Od9EmlsCk5R8IY79ly9ob726vscAVVADVea6JyGOPikcF0RBr53baL00irjhqfwBwwUNJWYMgbFvTa+QzqCllsKCSB6AQhX77wF5Vnu9zhV5GFd+m1CeSzdSBJZviJPYKzubvI3CfMW9YGMHWPiZrC8dFairVC6XoI74a3yPfClPcAHVcmNezC3Tj7VUKnGZVFkt1CeUPUBwJyw0RSRtVVv+zGlpzG0vpNaKBaDGgyfwqtR03s4cx1md5U3gSaa5JARWC8Zu/mImnEeP9Ksg9ZfiCpgl5v6VGXqGpe1pB6JZgr7CSyJQAI1ZEsJ83rPR3URhlXQV07LwW2gTcLF6MdmzGQcWC0oXR/OiHLqnj8nbrS2y8qmIbOgp61oZz6Ruc1mlKv49YI8zPrLnDbAGXkSv/XBgAErZ5tdGJ7n1KbgNWDQgA55vXabgFwb2EnR5fmVlw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b540fe-4505-4cc4-8f11-08d869019754
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2020 07:38:02.6211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wht23SYe+BmsaCl52nHDSY8mLzZfPH9Y67VkLwwgi6M+RZLI89fGQSIMPnRexLie6yv+NqGF9QMRBpYjUGaWZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3180
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v2 1/7] fpga: sec-mgr: intel fpga security manager class
> driver
>=20
> Create the Intel Security Manager class driver. The security
> manager provides interfaces to manage secure updates for the
> FPGA and BMC images that are stored in FLASH. The driver can
> also be used to update root entry hashes and to cancel code
> signing keys.
>=20
> This patch creates the class driver and provides sysfs
> interfaces for displaying root entry hashes, canceled code
> signing keys and flash counts.
>=20
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
> v2:
>   - Bumped documentation dates and versions
>   - Added Documentation/fpga/ifpga-sec-mgr.rst
>   - Removed references to bmc_flash_count & smbus_flash_count (not
> supported)
>   - Split ifpga_sec_mgr_register() into create() and register() functions
>   - Added devm_ifpga_sec_mgr_create()
>   - Removed typedefs for imgr ops
> ---
>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     |  67 +++
>  Documentation/fpga/ifpga-sec-mgr.rst          |  50 ++
>  Documentation/fpga/index.rst                  |   1 +
>  MAINTAINERS                                   |   9 +
>  drivers/fpga/Kconfig                          |   9 +
>  drivers/fpga/Makefile                         |   3 +
>  drivers/fpga/ifpga-sec-mgr.c                  | 432 ++++++++++++++++++
>  include/linux/fpga/ifpga-sec-mgr.h            |  81 ++++
>  8 files changed, 652 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>  create mode 100644 Documentation/fpga/ifpga-sec-mgr.rst
>  create mode 100644 drivers/fpga/ifpga-sec-mgr.c
>  create mode 100644 include/linux/fpga/ifpga-sec-mgr.h
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> new file mode 100644
> index 000000000000..707958971bcb
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> @@ -0,0 +1,67 @@
> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/name
> +Date:		Oct 2020
> +KernelVersion:  5.11
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Name of low level fpga security manager driver.
> +
> +What:
> 	/sys/class/ifpga_sec_mgr/ifpga_secX/security/sr_root_entry_hash
> +Date:		Oct 2020
> +KernelVersion:  5.11
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns the root entry hash for the static
> +		region if one is programmed, else it returns the
> +		string: "hash not programmed".  This file is only
> +		visible if the underlying device supports it.
> +		Format: "0x%x".
> +
> +What:
> 	/sys/class/ifpga_sec_mgr/ifpga_secX/security/pr_root_entry_hash
> +Date:		Oct 2020
> +KernelVersion:  5.11
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns the root entry hash for the partial
> +		reconfiguration region if one is programmed, else it
> +		returns the string: "hash not programmed".  This file
> +		is only visible if the underlying device supports it.
> +		Format: "0x%x".
> +
> +What:
> 	/sys/class/ifpga_sec_mgr/ifpga_secX/security/bmc_root_entry_hash
> +Date:		Oct 2020
> +KernelVersion:  5.11
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns the root entry hash for the BMC image
> +		if one is programmed, else it returns the string:
> +		"hash not programmed".  This file is only visible if the
> +		underlying device supports it.
> +		Format: "0x%x".
> +
> +What:
> 	/sys/class/ifpga_sec_mgr/ifpga_secX/security/sr_canceled_csks
> +Date:		Oct 2020
> +KernelVersion:  5.11
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns a list of indices for canceled code
> +		signing keys for the static region. The standard bitmap
> +		list format is used (e.g. "1,2-6,9").
> +
> +What:
> 	/sys/class/ifpga_sec_mgr/ifpga_secX/security/pr_canceled_csks
> +Date:		Oct 2020
> +KernelVersion:  5.11
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns a list of indices for canceled code
> +		signing keys for the partial reconfiguration region. The
> +		standard bitmap list format is used (e.g. "1,2-6,9").
> +
> +What:
> 	/sys/class/ifpga_sec_mgr/ifpga_secX/security/bmc_canceled_csks
> +Date:		Oct 2020
> +KernelVersion:  5.11
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns a list of indices for canceled code
> +		signing keys for the BMC.  The standard bitmap list format
> +		is used (e.g. "1,2-6,9").
> +
> +What:
> 	/sys/class/ifpga_sec_mgr/ifpga_secX/security/user_flash_count
> +Date:		Oct 2020
> +KernelVersion:  5.11
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns number of times the user image for the
> +		static region has been flashed.
> +		Format: "%u".
> diff --git a/Documentation/fpga/ifpga-sec-mgr.rst
> b/Documentation/fpga/ifpga-sec-mgr.rst
> new file mode 100644
> index 000000000000..02f3f65b182b
> --- /dev/null
> +++ b/Documentation/fpga/ifpga-sec-mgr.rst
> @@ -0,0 +1,50 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Intel FPGA Security Manager Class Driver
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The Intel FPGA Security Manager class driver provides a common
> +API for user-space tools to manage updates for secure Intel FPGA
> +devices. Device drivers that instantiate the Intel Security
> +Manager class driver will interact with a HW secure update
> +engine in order to transfer new FPGA and BMC images to FLASH so
> +that they will be automatically loaded when the FPGA card reboots.
> +
> +A significant difference between the FPGA Manager and the Intel FPGA
> +Security Manager is that the FPGA Manager does a live update (Partial
> +Reconfiguration) to a device, whereas the Intel FPGA Security Manager
> +updates the FLASH images for the Static Region and the BMC so that
> +they will be loaded the next time the FPGA card boots. Security is
> +enforced by hardware and firmware. The security manager interacts
> +with the firmware to initiate an update, pass in the necessary data,
> +and collect status on the update.
> +
> +In addition to managing secure updates of the FPGA and BMC images,
> +the Intel FPGA Security Manager update process may also used to
> +program root entry hashes and cancellation keys for the FPGA static
> +region, the FPGA partial reconfiguration region, and the BMC.
> +
> +Secure updates make use of the request_firmware framework, which
> +requires that image files are accessible under /lib/firmware. A request
> +for a secure update returns immediately, while the update itself
> +proceeds in the context of a kernel worker thread. Sysfs files provide
> +a means for monitoring the progress of a secure update and for
> +retrieving error information in the event of a failure.
> +
> +Sysfs Attributes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The API consists of two groups of sysfs attributes as described below.
> +
> +1. Files in the *security* sub-directory can be used to read security
> +   information including: Root Entry Hashes (REH), Cancelled Code
> +   Signing Keys (CSK), and the flash update count for FPGA images.
> +
> +2. Files in the *update* sub-directory can be used to instantiate and
> +   monitor a secure update.
> +
> +
> +See `<../ABI/testing/sysfs-class-ifpga-sec-mgr>`__ for a full
> +description of the sysfs attributes for the Intel FPGA Security
> +Manager.
> diff --git a/Documentation/fpga/index.rst b/Documentation/fpga/index.rst
> index f80f95667ca2..ba9c6b1917bd 100644
> --- a/Documentation/fpga/index.rst
> +++ b/Documentation/fpga/index.rst
> @@ -8,6 +8,7 @@ fpga
>      :maxdepth: 1
>=20
>      dfl
> +    ifpga-sec-mgr
>=20
>  .. only::  subproject and html
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6d1175bf8529..5ffc0e02d741 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6858,6 +6858,15 @@ F:	Documentation/fpga/
>  F:	drivers/fpga/
>  F:	include/linux/fpga/
>=20
> +INTEL FPGA SECURITY MANAGER DRIVERS
> +M:	Russ Weight <russell.h.weight@intel.com>
> +L:	linux-fpga@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> +F:	Documentation/fpga/ifpga-sec-mgr.rst
> +F:	drivers/fpga/ifpga-sec-mgr.c
> +F:	include/linux/fpga/ifpga-sec-mgr.h
> +
>  FPU EMULATOR
>  M:	Bill Metzenthen <billm@melbpc.org.au>
>  S:	Maintained
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 7cd5a29fc437..bf566a625be7 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -215,4 +215,13 @@ config FPGA_MGR_ZYNQMP_FPGA
>  	  to configure the programmable logic(PL) through PS
>  	  on ZynqMP SoC.
>=20
> +config IFPGA_SEC_MGR
> +	tristate "Intel Security Manager for FPGA"
> +	help
> +	  The Intel Security Manager class driver presents a common
> +	  user API for managing secure updates for Intel FPGA
> +	  devices, including flash images for the FPGA static
> +	  region and for the BMC. Select this option to enable
> +	  updates for secure FPGA devices.
> +
>  endif # FPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index d8e21dfc6778..2e1d29c3d915 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -21,6 +21,9 @@ obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+=3D
> zynqmp-fpga.o
>  obj-$(CONFIG_ALTERA_PR_IP_CORE)         +=3D altera-pr-ip-core.o
>  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    +=3D altera-pr-ip-core-plat.o
>=20
> +# Intel FPGA Security Manager Framework
> +obj-$(CONFIG_IFPGA_SEC_MGR)		+=3D ifpga-sec-mgr.o
> +
>  # FPGA Bridge Drivers
>  obj-$(CONFIG_FPGA_BRIDGE)		+=3D fpga-bridge.o
>  obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+=3D altera-hps2fpga.o altera-
> fpga2sdram.o
> diff --git a/drivers/fpga/ifpga-sec-mgr.c b/drivers/fpga/ifpga-sec-mgr.c
> new file mode 100644
> index 000000000000..f1caa4602ab3
> --- /dev/null
> +++ b/drivers/fpga/ifpga-sec-mgr.c
> @@ -0,0 +1,432 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Intel Security Manager for FPGA
> + *
> + * Copyright (C) 2019-2020 Intel Corporation, Inc.
> + */
> +
> +#include <linux/fpga/ifpga-sec-mgr.h>
> +#include <linux/idr.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/vmalloc.h>
> +
> +static DEFINE_IDA(ifpga_sec_mgr_ida);
> +static struct class *ifpga_sec_mgr_class;
> +
> +#define to_sec_mgr(d) container_of(d, struct ifpga_sec_mgr, dev)
> +
> +static ssize_t
> +show_canceled_csk(struct ifpga_sec_mgr *imgr,
> +		  int (*get_csk)(struct ifpga_sec_mgr *imgr,
> +				 unsigned long *csk_map, unsigned int nbits),
> +		  int (*get_csk_nbits)(struct ifpga_sec_mgr *imgr),
> +		  char *buf)
> +{
> +	unsigned long *csk_map =3D NULL;
> +	unsigned int nbits;
> +	int ret;
> +
> +	ret =3D get_csk_nbits(imgr);
> +	if (ret < 0)
> +		return ret;
> +
> +	nbits =3D (unsigned int)ret;
> +	csk_map =3D vmalloc(sizeof(unsigned long) * BITS_TO_LONGS(nbits));
> +	if (!csk_map)
> +		return -ENOMEM;
> +
> +	ret =3D get_csk(imgr, csk_map, nbits);
> +	if (ret)
> +		goto vfree_exit;
> +
> +	ret =3D bitmap_print_to_pagebuf(1, buf, csk_map, nbits);
> +
> +vfree_exit:
> +	vfree(csk_map);
> +	return ret;
> +}
> +
> +static ssize_t
> +show_root_entry_hash(struct ifpga_sec_mgr *imgr,
> +		     int (*get_reh)(struct ifpga_sec_mgr *imgr, u8 *hash,
> +				    unsigned int size),
> +		     int (*get_reh_size)(struct ifpga_sec_mgr *imgr),
> +		     char *buf)
> +{
> +	int size, i, cnt, ret;
> +	u8 *hash;
> +
> +	ret =3D get_reh_size(imgr);
> +	if (ret < 0)
> +		return ret;
> +	else if (!ret)
> +		return sprintf(buf, "hash not programmed\n");
> +
> +	size =3D ret;
> +	hash =3D vmalloc(size);
> +	if (!hash)
> +		return -ENOMEM;
> +
> +	ret =3D get_reh(imgr, hash, size);
> +	if (ret)
> +		goto vfree_exit;
> +
> +	cnt =3D sprintf(buf, "0x");
> +	for (i =3D 0; i < size; i++)
> +		cnt +=3D sprintf(buf + cnt, "%02x", hash[i]);
> +	cnt +=3D sprintf(buf + cnt, "\n");
> +
> +vfree_exit:
> +	vfree(hash);
> +	return ret ? : cnt;
> +}
> +
> +#define DEVICE_ATTR_SEC_CSK(_name) \
> +static ssize_t _name##_canceled_csks_show(struct device *dev, \
> +					  struct device_attribute *attr, \
> +					  char *buf) \
> +{ \
> +	struct ifpga_sec_mgr *imgr =3D to_sec_mgr(dev); \
> +	return show_canceled_csk(imgr, \
> +	       imgr->iops->_name##_canceled_csks, \
> +	       imgr->iops->_name##_canceled_csk_nbits, buf); \
> +} \
> +static DEVICE_ATTR_RO(_name##_canceled_csks)
> +
> +#define DEVICE_ATTR_SEC_ROOT_ENTRY_HASH(_name) \
> +static ssize_t _name##_root_entry_hash_show(struct device *dev, \
> +				     struct device_attribute *attr, \
> +				     char *buf) \
> +{ \
> +	struct ifpga_sec_mgr *imgr =3D to_sec_mgr(dev); \
> +	return show_root_entry_hash(imgr, \
> +	       imgr->iops->_name##_root_entry_hash, \
> +	       imgr->iops->_name##_reh_size, buf); \
> +} \
> +static DEVICE_ATTR_RO(_name##_root_entry_hash)
> +
> +static ssize_t user_flash_count_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct ifpga_sec_mgr *imgr =3D to_sec_mgr(dev);
> +
> +	int cnt =3D imgr->iops->user_flash_count(imgr);
> +	return cnt < 0 ? cnt : sprintf(buf, "%u\n", cnt);
> +}
> +static DEVICE_ATTR_RO(user_flash_count);
> +
> +DEVICE_ATTR_SEC_ROOT_ENTRY_HASH(sr);
> +DEVICE_ATTR_SEC_ROOT_ENTRY_HASH(pr);
> +DEVICE_ATTR_SEC_ROOT_ENTRY_HASH(bmc);
> +DEVICE_ATTR_SEC_CSK(sr);
> +DEVICE_ATTR_SEC_CSK(pr);
> +DEVICE_ATTR_SEC_CSK(bmc);
> +
> +static struct attribute *sec_mgr_security_attrs[] =3D {
> +	&dev_attr_user_flash_count.attr,
> +	&dev_attr_bmc_root_entry_hash.attr,
> +	&dev_attr_sr_root_entry_hash.attr,
> +	&dev_attr_pr_root_entry_hash.attr,
> +	&dev_attr_sr_canceled_csks.attr,
> +	&dev_attr_pr_canceled_csks.attr,
> +	&dev_attr_bmc_canceled_csks.attr,
> +	NULL,
> +};
> +
> +#define check_attr(attribute, _name) \
> +	((attribute) =3D=3D &dev_attr_##_name.attr && imgr->iops->_name)
> +
> +static umode_t sec_mgr_visible(struct kobject *kobj,
> +			       struct attribute *attr, int n)
> +{
> +	struct ifpga_sec_mgr *imgr =3D to_sec_mgr(kobj_to_dev(kobj));
> +
> +	/*
> +	 * Only display optional sysfs attributes if a
> +	 * corresponding handler is provided
> +	 */
> +	if (check_attr(attr, user_flash_count) ||
> +	    check_attr(attr, bmc_root_entry_hash) ||
> +	    check_attr(attr, sr_root_entry_hash) ||
> +	    check_attr(attr, pr_root_entry_hash) ||
> +	    check_attr(attr, sr_canceled_csks) ||
> +	    check_attr(attr, pr_canceled_csks) ||
> +	    check_attr(attr, bmc_canceled_csks))
> +		return attr->mode;
> +
> +	return 0;
> +}
> +
> +static struct attribute_group sec_mgr_security_attr_group =3D {
> +	.name =3D "security",
> +	.attrs =3D sec_mgr_security_attrs,
> +	.is_visible =3D sec_mgr_visible,
> +};
> +
> +static ssize_t name_show(struct device *dev,
> +			 struct device_attribute *attr, char *buf)
> +{
> +	struct ifpga_sec_mgr *imgr =3D to_sec_mgr(dev);
> +
> +	return sprintf(buf, "%s\n", imgr->name);
> +}
> +static DEVICE_ATTR_RO(name);
> +
> +static struct attribute *sec_mgr_attrs[] =3D {
> +	&dev_attr_name.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group sec_mgr_attr_group =3D {
> +	.attrs =3D sec_mgr_attrs,
> +};
> +
> +static const struct attribute_group *ifpga_sec_mgr_attr_groups[] =3D {
> +	&sec_mgr_attr_group,
> +	&sec_mgr_security_attr_group,
> +	NULL,
> +};
> +
> +static bool check_sysfs_handler(struct device *dev,
> +				void *sysfs_handler, void *size_handler,
> +				const char *sysfs_handler_name,
> +				const char *size_handler_name)
> +{
> +	/*
> +	 * sysfs_handler and size_handler must either both be
> +	 * defined or both be NULL.
> +	 */
> +	if (sysfs_handler) {
> +		if (!size_handler) {
> +			dev_err(dev, "%s registered without %s\n",
> +				sysfs_handler_name, size_handler_name);
> +			return false;
> +		}
> +	} else if (size_handler) {
> +		dev_err(dev, "%s registered without %s\n",
> +			size_handler_name, sysfs_handler_name);
> +		return false;
> +	}

Optional:

	If (sysfs_handler && !size_handler) {

	} else if (!sysfs_handler && size_handler) {
=09
	}

> +	return true;
> +}
> +
> +#define check_reh_handler(_dev, _iops, _name) \
> +	check_sysfs_handler(_dev, (_iops)->_name##_root_entry_hash, \
> +			    (_iops)->_name##_reh_size, \
> +			    __stringify(_name##_root_entry_hash), \
> +			    __stringify(_name##_reh_size))
> +
> +#define check_csk_handler(_dev, _iops, _name) \
> +	check_sysfs_handler(_dev, (_iops)->_name##_canceled_csks, \
> +			    (_iops)->_name##_canceled_csk_nbits, \
> +			    __stringify(_name##_canceled_csks), \
> +			    __stringify(_name##_canceled_csk_nbits))
> +
> +/**
> + * ifpga_sec_mgr_create - create and initialize an Intel FPGA
> + *			  security manager struct
> + *
> + * @dev:  Intel fpga security manager device from pdev
> + * @name: ifpga security manager name
> + * @iops: pointer to a structure of ifpga callback functions
> + * @priv: ifpga security manager private data
> + *
> + * The caller of this function is responsible for freeing the struct
> + * with ifpg_sec_mgr_free(). Using devm_ifpga_sec_mgr_create() instead
> + * is recommended.
> + *
> + * Return: pointer to struct ifpga_sec_mgr or NULL
> + */
> +struct ifpga_sec_mgr *
> +ifpga_sec_mgr_create(struct device *dev, const char *name,
> +		     const struct ifpga_sec_mgr_ops *iops, void *priv)
> +{
> +	struct ifpga_sec_mgr *imgr;
> +	int id, ret;
> +
> +	if (!check_reh_handler(dev, iops, bmc) ||
> +	    !check_reh_handler(dev, iops, sr) ||
> +	    !check_reh_handler(dev, iops, pr) ||
> +	    !check_csk_handler(dev, iops, bmc) ||
> +	    !check_csk_handler(dev, iops, sr) ||
> +	    !check_csk_handler(dev, iops, pr)) {
> +		return NULL;
> +	}
> +
> +	if (!name || !strlen(name)) {
> +		dev_err(dev, "Attempt to register with no name!\n");
> +		return NULL;
> +	}
> +
> +	imgr =3D kzalloc(sizeof(*imgr), GFP_KERNEL);
> +	if (!imgr)
> +		return NULL;
> +
> +	id =3D ida_simple_get(&ifpga_sec_mgr_ida, 0, 0, GFP_KERNEL);
> +	if (id < 0)
> +		goto error_kfree;
> +
> +	mutex_init(&imgr->lock);
> +
> +	imgr->name =3D name;
> +	imgr->priv =3D priv;
> +	imgr->iops =3D iops;
> +
> +	device_initialize(&imgr->dev);
> +	imgr->dev.class =3D ifpga_sec_mgr_class;
> +	imgr->dev.parent =3D dev;
> +	imgr->dev.id =3D id;
> +
> +	ret =3D dev_set_name(&imgr->dev, "ifpga_sec%d", id);
> +	if (ret) {
> +		dev_err(dev, "Failed to set device name: ifpga_sec%d\n", id);
> +		goto error_device;
> +	}
> +
> +	return imgr;
> +
> +error_device:
> +	ida_simple_remove(&ifpga_sec_mgr_ida, id);
> +
> +error_kfree:
> +	kfree(imgr);
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(ifpga_sec_mgr_create);
> +
> +/**
> + * ifpga_sec_mgr_free - free an Intel FPGA security manager created
> + *			with ifpga_sec_mgr_create()
> + *
> + * @imgr:	Intel FPGA security manager structure
> + */
> +void ifpga_sec_mgr_free(struct ifpga_sec_mgr *imgr)
> +{
> +	ida_simple_remove(&ifpga_sec_mgr_ida, imgr->dev.id);
> +	kfree(imgr);
> +}
> +EXPORT_SYMBOL_GPL(ifpga_sec_mgr_free);
> +
> +static void devm_ifpga_sec_mgr_release(struct device *dev, void *res)
> +{
> +	struct ifpga_sec_mgr *imgr =3D *(struct ifpga_sec_mgr **)res;
> +
> +	ifpga_sec_mgr_free(imgr);
> +}
> +
> +/**
> + * devm_ifpga_sec_mgr_create - create and initialize an Intel FPGA
> + *			       security manager struct
> + *
> + * @dev:  Intel fpga security manager device from pdev
> + * @name: ifpga security manager name
> + * @iops: pointer to a structure of ifpga callback functions
> + * @priv: ifpga security manager private data
> + *
> + * This function is intended for use in a Intel FPGA Security manager
> + * driver's probe function.  After the security manager driver creates
> + * the ifpga_sec_mgr struct with devm_fpga_mgr_create(), it should
> + * register it with ifpga_sec_mgr_register().  The security manager
> + * driver's remove function should call ifpga_sec_mgr_unregister().
> + * The ifpga_sec_mgr struct allocated with this function will be freed
> + * automatically on driver detach.  This includes the case of a probe
> + * function returning error before calling fpga_mgr_register(), the
> + * struct will still get cleaned up.
> + *
> + * Return: pointer to struct ifpga_sec_mgr or NULL
> + */
> +struct ifpga_sec_mgr *
> +devm_ifpga_sec_mgr_create(struct device *dev, const char *name,
> +			  const struct ifpga_sec_mgr_ops *iops, void *priv)
> +{
> +	struct ifpga_sec_mgr **ptr, *imgr;
> +
> +	ptr =3D devres_alloc(devm_ifpga_sec_mgr_release, sizeof(*ptr),
> GFP_KERNEL);
> +	if (!ptr)
> +		return NULL;
> +
> +	imgr =3D ifpga_sec_mgr_create(dev, name, iops, priv);
> +	if (!imgr) {
> +		devres_free(ptr);
> +	} else {
> +		*ptr =3D imgr;
> +		devres_add(dev, ptr);
> +	}
> +
> +	return imgr;
> +}
> +EXPORT_SYMBOL_GPL(devm_ifpga_sec_mgr_create);
> +
> +/**
> + * ifpga_sec_mgr_register - register an Intel FPGA security manager
> + *
> + * @imgr: Intel fpga security manager struct
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +int ifpga_sec_mgr_register(struct ifpga_sec_mgr *imgr)
> +{
> +	int ret;
> +
> +	ret =3D device_add(&imgr->dev);
> +	if (ret)
> +		goto error_device;
> +
> +	dev_info(&imgr->dev, "%s registered\n", imgr->name);
> +
> +	return 0;
> +
> +error_device:
> +	ida_simple_remove(&ifpga_sec_mgr_ida, imgr->dev.id);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ifpga_sec_mgr_register);
> +
> +/**
> + * ifpga_sec_mgr_unregister - unregister an Intel FPGA security manager
> + *
> + * @mgr: fpga manager struct
> + *
> + * This function is intended for use in an Intel FPGA security manager
> + * driver's remove() function.
> + */
> +void ifpga_sec_mgr_unregister(struct ifpga_sec_mgr *imgr)
> +{
> +	dev_info(&imgr->dev, "%s %s\n", __func__, imgr->name);
> +
> +	device_unregister(&imgr->dev);
> +}
> +EXPORT_SYMBOL_GPL(ifpga_sec_mgr_unregister);
> +
> +static void ifpga_sec_mgr_dev_release(struct device *dev)
> +{
> +}
> +
> +static int __init ifpga_sec_mgr_class_init(void)
> +{
> +	pr_info("Intel FPGA Security Manager\n");
> +
> +	ifpga_sec_mgr_class =3D class_create(THIS_MODULE, "ifpga_sec_mgr");
> +	if (IS_ERR(ifpga_sec_mgr_class))
> +		return PTR_ERR(ifpga_sec_mgr_class);
> +
> +	ifpga_sec_mgr_class->dev_groups =3D ifpga_sec_mgr_attr_groups;
> +	ifpga_sec_mgr_class->dev_release =3D ifpga_sec_mgr_dev_release;
> +
> +	return 0;
> +}
> +
> +static void __exit ifpga_sec_mgr_class_exit(void)
> +{
> +	class_destroy(ifpga_sec_mgr_class);
> +	ida_destroy(&ifpga_sec_mgr_ida);
> +}
> +
> +MODULE_DESCRIPTION("Intel FPGA Security Manager Driver");
> +MODULE_LICENSE("GPL v2");
> +
> +subsys_initcall(ifpga_sec_mgr_class_init);
> +module_exit(ifpga_sec_mgr_class_exit)
> diff --git a/include/linux/fpga/ifpga-sec-mgr.h b/include/linux/fpga/ifpg=
a-
> sec-mgr.h
> new file mode 100644
> index 000000000000..ded62090e9b9
> --- /dev/null
> +++ b/include/linux/fpga/ifpga-sec-mgr.h
> @@ -0,0 +1,81 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Header file for Intel FPGA Security Manager
> + *
> + * Copyright (C) 2019-2020 Intel Corporation, Inc.
> + */
> +#ifndef _LINUX_IFPGA_SEC_MGR_H
> +#define _LINUX_IFPGA_SEC_MGR_H
> +
> +#include <linux/device.h>
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +
> +struct ifpga_sec_mgr;
> +
> +/**
> + * struct ifpga_sec_mgr_ops - device specific operations
> + * @user_flash_count:	    Optional: Return sysfs string output for
> FPGA
> + *			    image flash count
> + * @sr_root_entry_hash:	    Optional: Return sysfs string output for
> static
> + *			    region root entry hash
> + * @pr_root_entry_hash:	    Optional: Return sysfs string output for
> partial
> + *			    reconfiguration root entry hash
> + * @bmc_root_entry_hash:    Optional: Return sysfs string output for BMC
> + *			    root entry hash
> + * @sr_canceled_csks:	    Optional: Return sysfs string output for stati=
c
> + *			    region canceled keys
> + * @pr_canceled_csks:	    Optional: Return sysfs string output for
> partial
> + *			    reconfiguration canceled keys
> + * @bmc_canceled_csks:	    Optional: Return sysfs string output for
> bmc
> + *			    canceled keys
> + * @bmc_canceled_csk_nbits: Optional: Return BMC canceled csk vector bit
> count
> + * @sr_canceled_csk_nbits:  Optional: Return SR canceled csk vector bit
> count
> + * @pr_canceled_csk_nbits:  Optional: Return PR canceled csk vector bit
> count
> + * @bmc_reh_size:	    Optional: Return byte size for BMC root entry hash
> + * @sr_reh_size:	    Optional: Return byte size for SR root entry hash
> + * @pr_reh_size:	    Optional: Return byte size for PR root entry hash
> + */
> +struct ifpga_sec_mgr_ops {
> +	int (*user_flash_count)(struct ifpga_sec_mgr *imgr);
> +	int (*bmc_root_entry_hash)(struct ifpga_sec_mgr *imgr, u8 *hash,
> +				   unsigned int size);
> +	int (*sr_root_entry_hash)(struct ifpga_sec_mgr *imgr, u8 *hash,
> +				  unsigned int size);
> +	int (*pr_root_entry_hash)(struct ifpga_sec_mgr *imgr, u8 *hash,
> +				  unsigned int size);
> +	int (*bmc_canceled_csks)(struct ifpga_sec_mgr *imgr,
> +				 unsigned long *csk_map, unsigned int nbits);
> +	int (*sr_canceled_csks)(struct ifpga_sec_mgr *imgr,
> +				unsigned long *csk_map, unsigned int nbits);
> +	int (*pr_canceled_csks)(struct ifpga_sec_mgr *imgr,
> +				unsigned long *csk_map, unsigned int nbits);
> +	int (*bmc_reh_size)(struct ifpga_sec_mgr *imgr);
> +	int (*sr_reh_size)(struct ifpga_sec_mgr *imgr);
> +	int (*pr_reh_size)(struct ifpga_sec_mgr *imgr);
> +	int (*bmc_canceled_csk_nbits)(struct ifpga_sec_mgr *imgr);
> +	int (*sr_canceled_csk_nbits)(struct ifpga_sec_mgr *imgr);
> +	int (*pr_canceled_csk_nbits)(struct ifpga_sec_mgr *imgr);

I am thinking that if these callbacks for size are really needed or not.
If these size values are not changed dynamically, which requires no
recalculation, then these size values can be stored in ifpga sec mgr
data structure directly. I think the checking logic could be simpler too.
Do you think if it is possible?

Thanks
Hao

> +};
> +
> +struct ifpga_sec_mgr {
> +	const char *name;
> +	struct device dev;
> +	const struct ifpga_sec_mgr_ops *iops;
> +	struct mutex lock;		/* protect data structure contents */
> +	void *priv;
> +};
> +
> +struct ifpga_sec_mgr *
> +ifpga_sec_mgr_create(struct device *dev, const char *name,
> +		     const struct ifpga_sec_mgr_ops *iops, void *priv);
> +
> +struct ifpga_sec_mgr *
> +devm_ifpga_sec_mgr_create(struct device *dev, const char *name,
> +			  const struct ifpga_sec_mgr_ops *iops, void *priv);
> +
> +int ifpga_sec_mgr_register(struct ifpga_sec_mgr *imgr);
> +void ifpga_sec_mgr_unregister(struct ifpga_sec_mgr *imgr);
> +void ifpga_sec_mgr_free(struct ifpga_sec_mgr *imgr);
> +
> +#endif
> --
> 2.17.1

