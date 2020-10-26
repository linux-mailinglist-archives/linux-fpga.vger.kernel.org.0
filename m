Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCDC29858D
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Oct 2020 03:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421420AbgJZC36 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 25 Oct 2020 22:29:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:38650 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1421419AbgJZC35 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 25 Oct 2020 22:29:57 -0400
IronPort-SDR: FGY93QYpB/jqM4KBxxg96+NWrS5FzYHgbYivGAk22mdulAe1nezABuz6kT/fY798FUE8388rUA
 QCLdVhflTYWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9785"; a="167967117"
X-IronPort-AV: E=Sophos;i="5.77,417,1596524400"; 
   d="scan'208";a="167967117"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2020 19:29:56 -0700
IronPort-SDR: nS6y3fY7sWqnq+waPbUWkSp9NBSMU3gqka2wl4VpMLrzBku3ZVJ19+Y4f9XSjBOWk2m38Bwp6t
 pP9yzzWxUhgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,417,1596524400"; 
   d="scan'208";a="317714257"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2020 19:29:56 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 25 Oct 2020 19:29:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 25 Oct 2020 19:29:56 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.54) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 25 Oct 2020 19:29:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/7lJIsy2QkO7XpBwEpHGEOAHcF68TDRswmHj2aatkrFYV2juXMhamFhKvigaO9PGjaSrU9th+N9PtWP774RtFzGVCaK/BgNIUwq4F1Jujdd9EGuJSiFYUcMeRiJV0KT6YZHpaYs/F0o2rPoa2gyjrVJ/mS9/769QJCSFmoQ8miLK3UzgyDpG217Yy+1JujtCnAYXApU4GxZjVw36Mym6gZTZTSfAi8ErK+trkIHBjdMqboyW78SFWyVQjWhtW2s8+MOo9E7QkPl4QVCHTBe7PHbxsnk+fCsr2D6iS96nUqGh2YwIqavymqZ1pEbMDFWAgJImxZ3KzWYqbb9x5CCPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpQG57bidGbV6UNkIO+G/Iy9b/kWijhyUJeAFVJ5Mxw=;
 b=SHzBUmTZ8E8OP5JBHwlOBNpZtt3H9STJD63d5MUzdhdELbXMXL5WAAq6CRGbiPXf2yGavWL49jnrFrcg1CeSIUc2TofIEbKqDPHtNLt0dUVK2owuSB1Xb70xFGI3l1cHcEj5tYS8D7T+3QsMzT4ISWXLPmfEl9lnCEMKZ75VAAoEBR51BFO74+8rMnv19EH9DmXFQdKG0gsxuDAbRzgWE4w228e2WNPAiey/fUYYwWDR8+5BgbeV0dmlxSt65OivZMt2YI3dk9oxv6y7wUd/VnOjEmyJRlv9P45taWITjPfdSW5DybiUqi17sOjwYG8WhZhTWPELCsfSmdXhnF6R4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpQG57bidGbV6UNkIO+G/Iy9b/kWijhyUJeAFVJ5Mxw=;
 b=ZrVTUuW27wobRW3yR4W70ddPZxVucC4hIK1Cf1Wjzg4nWq/evWjI7nWfzAZB2IMYVdV99scuXsJsKr3q6KjNwfxF29lYAYCOVq9evXkZUoVEv2yWKwkzr/WWD6WGCOXamF8Vkf6JlCtXD+nocuntxYc4Xprry0U3KRFAwCXlOh4=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB4675.namprd11.prod.outlook.com (2603:10b6:5:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Mon, 26 Oct
 2020 02:29:47 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::69e0:a898:de56:337c]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::69e0:a898:de56:337c%7]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 02:29:47 +0000
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
Subject: RE: [PATCH v5 1/7] fpga: sec-mgr: intel fpga security manager class
 driver
Thread-Topic: [PATCH v5 1/7] fpga: sec-mgr: intel fpga security manager class
 driver
Thread-Index: AQHWpz+CBqKarBs7vkygr5D2jWIF+6mpLzMw
Date:   Mon, 26 Oct 2020 02:29:47 +0000
Message-ID: <DM6PR11MB3819FE25626E8ECC308A666385190@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20201021001650.13978-1-russell.h.weight@intel.com>
 <20201021001650.13978-2-russell.h.weight@intel.com>
In-Reply-To: <20201021001650.13978-2-russell.h.weight@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47d0e018-73d7-4d3e-b518-08d87957022d
x-ms-traffictypediagnostic: DM6PR11MB4675:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4675276B8B3DB447FF36276A85190@DM6PR11MB4675.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jVkl6blISbsvYcgzJbqbl9pfK/Ine+h1RlM5crNBvqqeAGj6WyrtkpEU9ytPv0hbp1DxncwtIP766KfRF1DnRwF+/YkqshoV0vzr8NnBE4FPaXOoGEbH4dlL04cUX/Vp5aslUm7b2GKg2EEHUoEahrVoexMzct0sAes85SH0ZGJJiKHspBmf0XsDpwHg34iJWSqKoemoB2z8q2dDoqYwpxvCTSEpsTlcliLp1Qm/KZXPT9fuJpx5F31Ez5Cx/M+uAVRrh8KUbhKqDHeDQbtn2NKdBZGyXdY1lFPMqvoexElmGF747iiGshNOVtl3N4N9Fe69l9ci26GcY7aIgU0Rfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(2906002)(110136005)(8936002)(33656002)(54906003)(107886003)(55016002)(71200400001)(4326008)(478600001)(76116006)(186003)(30864003)(66556008)(6506007)(5660300002)(9686003)(86362001)(83380400001)(64756008)(66476007)(26005)(8676002)(316002)(66446008)(7696005)(66946007)(15650500001)(52536014)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /UY093BF1ytFT5lQ/WMbXyykoIRlINEoKujV73wTTNgRcNiJtzDkiYp5OMBsWSjxnFFlcmZR7U0EOd1bD7cfx/H98E6SPQLSylCdqYL5xeh1TBKGdVYVO0I+Y5gS6sJZUzjtelRurCvBjIIGb0jJlpnLW3MMraJ4prgGvUG8Y+4Zj7Ao3hlmxUkF0wCRBu8PqmIQcioFFUU53dVzlYcejaquNzMUpL6DBYHVmq8//hYZZu4NO4swzBrn42v6L86jcvo7FmA4SKeKTwYgiOVRuHgYBDtj4BV7Xc9VFm71odmlJf8BW6KRZ2gZUS15SFEOIXmZY872vs6x6SpaJeJLwSw5D/20wvIL4q4lksXWbAD0/g7WLkYW+jnryYjZoMhAH4ThU65FqW7QmAA9SXLohK4sebvOIZY7oqHP+CCxZW53PLb0dyTNZHysLmeN0EbvWuzvk92t2Auwvq/f16bYgjf+SzLhIPVdAK8kyWik0/4P8yUbtxxTQbV2IW4R8KJM1z6/zDbz5wMMKU+sLFRpXr1MuCosObz7twLRPqjMhSj2czbr2BX04lV5jQIelUU9kPHjSdVEzPrWj4VRU4w03vttub1+OVp5+ctC4AhN0Nksg/NkwQF+CcWTiuFOQvWO8GLlwXN7EE7tF35cxUVwcA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d0e018-73d7-4d3e-b518-08d87957022d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2020 02:29:47.7611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PbyQv+uq7i8tbvQityPvp9LUGQF34Mx4i/4jJ9xcYC84l4lTIu0LeKBGtSH4KYjLfoFIg6+Bb5nKcA+0Sl1LAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4675
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v5 1/7] fpga: sec-mgr: intel fpga security manager class
> driver
>=20
> Create the FPGA Security Manager class driver. The security
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
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
> v5:
>   - Added the devm_fpga_sec_mgr_unregister() function, following recent
>     changes to the fpga_manager() implementation.
>   - Changed some *_show() functions to use sysfs_emit() instead of sprint=
f(
> v4:
>   - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
>     and removed unnecessary references to "Intel".
>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
> v3:
>   - Modified sysfs handler check in check_sysfs_handler() to make
>     it more readable.
> v2:
>   - Bumped documentation dates and versions
>   - Added Documentation/fpga/ifpga-sec-mgr.rst
>   - Removed references to bmc_flash_count & smbus_flash_count (not
> supported)
>   - Split ifpga_sec_mgr_register() into create() and register() functions
>   - Added devm_ifpga_sec_mgr_create()
>   - Removed typedefs for imgr ops
> ---
>  .../ABI/testing/sysfs-class-fpga-sec-mgr      |  67 +++
>  Documentation/fpga/fpga-sec-mgr.rst           |  50 ++
>  Documentation/fpga/index.rst                  |   1 +
>  MAINTAINERS                                   |   9 +
>  drivers/fpga/Kconfig                          |   9 +
>  drivers/fpga/Makefile                         |   3 +
>  drivers/fpga/fpga-sec-mgr.c                   | 487 ++++++++++++++++++
>  include/linux/fpga/fpga-sec-mgr.h             |  83 +++
>  8 files changed, 709 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
>  create mode 100644 Documentation/fpga/fpga-sec-mgr.rst
>  create mode 100644 drivers/fpga/fpga-sec-mgr.c
>  create mode 100644 include/linux/fpga/fpga-sec-mgr.h
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> new file mode 100644
> index 000000000000..843f0b58f171
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> @@ -0,0 +1,67 @@
> +What: 		/sys/class/fpga_sec_mgr/fpga_secX/name
> +Date:		Oct 2020
> +KernelVersion:  5.11
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Name of low level fpga security manager driver.
> +
> +What:
> 	/sys/class/fpga_sec_mgr/fpga_secX/security/sr_root_entry_hash
> +Date:		Oct 2020
> +KernelVersion:  5.11
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns the root entry hash for the static
> +		region if one is programmed, else it returns the
> +		string: "hash not programmed".  This file is only
> +		visible if the underlying device supports it.
> +		Format: "0x%x".
> +

If we plan to make this class driver a common one for everybody, then
these sysfs defined here sounds a little device-specific? This is just my
personal feeling, Moritz and Tom, how do you guys think about these ones?

Hao

> +What:
> 	/sys/class/fpga_sec_mgr/fpga_secX/security/pr_root_entry_hash
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
> 	/sys/class/fpga_sec_mgr/fpga_secX/security/bmc_root_entry_hash
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
> 	/sys/class/fpga_sec_mgr/fpga_secX/security/sr_canceled_csks
> +Date:		Oct 2020
> +KernelVersion:  5.11
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns a list of indices for canceled code
> +		signing keys for the static region. The standard bitmap
> +		list format is used (e.g. "1,2-6,9").
> +
> +What:
> 	/sys/class/fpga_sec_mgr/fpga_secX/security/pr_canceled_csks
> +Date:		Oct 2020
> +KernelVersion:  5.11
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns a list of indices for canceled code
> +		signing keys for the partial reconfiguration region. The
> +		standard bitmap list format is used (e.g. "1,2-6,9").
> +
> +What:
> 	/sys/class/fpga_sec_mgr/fpga_secX/security/bmc_canceled_csks
> +Date:		Oct 2020
> +KernelVersion:  5.11
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns a list of indices for canceled code
> +		signing keys for the BMC.  The standard bitmap list format
> +		is used (e.g. "1,2-6,9").
> +
> +What:
> 	/sys/class/fpga_sec_mgr/fpga_secX/security/user_flash_count
> +Date:		Oct 2020
> +KernelVersion:  5.11
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns number of times the user image for the
> +		static region has been flashed.
> +		Format: "%u".
> diff --git a/Documentation/fpga/fpga-sec-mgr.rst
> b/Documentation/fpga/fpga-sec-mgr.rst
> new file mode 100644
> index 000000000000..4a1d6519b1d3
> --- /dev/null
> +++ b/Documentation/fpga/fpga-sec-mgr.rst
> @@ -0,0 +1,50 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +FPGA Security Manager Class Driver
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The FPGA Security Manager class driver provides a common
> +API for user-space tools to manage updates for secure FPGA
> +devices. Device drivers that instantiate the Security
> +Manager class driver will interact with a HW secure update
> +engine in order to transfer new FPGA and BMC images to FLASH so
> +that they will be automatically loaded when the FPGA card reboots.
> +
> +A significant difference between the FPGA Manager and the FPGA
> +Security Manager is that the FPGA Manager does a live update (Partial
> +Reconfiguration) to a device, whereas the FPGA Security Manager
> +updates the FLASH images for the Static Region and the BMC so that
> +they will be loaded the next time the FPGA card boots. Security is
> +enforced by hardware and firmware. The security manager interacts
> +with the firmware to initiate an update, pass in the necessary data,
> +and collect status on the update.
> +
> +In addition to managing secure updates of the FPGA and BMC images,
> +the FPGA Security Manager update process may also used to
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
> +See `<../ABI/testing/sysfs-class-fpga-sec-mgr>`__ for a full
> +description of the sysfs attributes for the FPGA Security
> +Manager.
> diff --git a/Documentation/fpga/index.rst b/Documentation/fpga/index.rst
> index f80f95667ca2..0b2f427042af 100644
> --- a/Documentation/fpga/index.rst
> +++ b/Documentation/fpga/index.rst
> @@ -8,6 +8,7 @@ fpga
>      :maxdepth: 1
>=20
>      dfl
> +    fpga-sec-mgr
>=20
>  .. only::  subproject and html
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4538378de6f5..7997fff716a8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6901,6 +6901,15 @@ F:	Documentation/fpga/
>  F:	drivers/fpga/
>  F:	include/linux/fpga/
>=20
> +FPGA SECURITY MANAGER DRIVERS
> +M:	Russ Weight <russell.h.weight@intel.com>
> +L:	linux-fpga@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> +F:	Documentation/fpga/fpga-sec-mgr.rst
> +F:	drivers/fpga/fpga-sec-mgr.c
> +F:	include/linux/fpga/fpga-sec-mgr.h
> +
>  FPU EMULATOR
>  M:	Bill Metzenthen <billm@melbpc.org.au>
>  S:	Maintained
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 7cd5a29fc437..6810b23b178d 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -215,4 +215,13 @@ config FPGA_MGR_ZYNQMP_FPGA
>  	  to configure the programmable logic(PL) through PS
>  	  on ZynqMP SoC.
>=20
> +config FPGA_SEC_MGR
> +	tristate "FPGA Security Manager"
> +	help
> +	  The Security Manager class driver presents a common
> +	  user API for managing secure updates for FPGA
> +	  devices, including flash images for the FPGA static
> +	  region and for the BMC. Select this option to enable
> +	  updates for secure FPGA devices.
> +
>  endif # FPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index d8e21dfc6778..0e357262faed 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -21,6 +21,9 @@ obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+=3D
> zynqmp-fpga.o
>  obj-$(CONFIG_ALTERA_PR_IP_CORE)         +=3D altera-pr-ip-core.o
>  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    +=3D altera-pr-ip-core-plat.o
>=20
> +# FPGA Security Manager Framework
> +obj-$(CONFIG_FPGA_SEC_MGR)		+=3D fpga-sec-mgr.o
> +
>  # FPGA Bridge Drivers
>  obj-$(CONFIG_FPGA_BRIDGE)		+=3D fpga-bridge.o
>  obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+=3D altera-hps2fpga.o altera-
> fpga2sdram.o
> diff --git a/drivers/fpga/fpga-sec-mgr.c b/drivers/fpga/fpga-sec-mgr.c
> new file mode 100644
> index 000000000000..95b5a7ccbe44
> --- /dev/null
> +++ b/drivers/fpga/fpga-sec-mgr.c
> @@ -0,0 +1,487 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * FPGA Security Manager
> + *
> + * Copyright (C) 2019-2020 Intel Corporation, Inc.
> + */
> +
> +#include <linux/fpga/fpga-sec-mgr.h>
> +#include <linux/idr.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/vmalloc.h>
> +
> +static DEFINE_IDA(fpga_sec_mgr_ida);
> +static struct class *fpga_sec_mgr_class;
> +
> +struct fpga_sec_mgr_devres {
> +	struct fpga_sec_mgr *smgr;
> +};
> +
> +#define to_sec_mgr(d) container_of(d, struct fpga_sec_mgr, dev)
> +
> +static ssize_t
> +show_canceled_csk(struct fpga_sec_mgr *smgr,
> +		  int (*get_csk)(struct fpga_sec_mgr *smgr,
> +				 unsigned long *csk_map, unsigned int nbits),
> +		  int (*get_csk_nbits)(struct fpga_sec_mgr *smgr),
> +		  char *buf)
> +{
> +	unsigned long *csk_map =3D NULL;
> +	unsigned int nbits;
> +	int ret;
> +
> +	ret =3D get_csk_nbits(smgr);
> +	if (ret < 0)
> +		return ret;
> +
> +	nbits =3D (unsigned int)ret;
> +	csk_map =3D vmalloc(sizeof(unsigned long) * BITS_TO_LONGS(nbits));
> +	if (!csk_map)
> +		return -ENOMEM;
> +
> +	ret =3D get_csk(smgr, csk_map, nbits);
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
> +show_root_entry_hash(struct fpga_sec_mgr *smgr,
> +		     int (*get_reh)(struct fpga_sec_mgr *smgr, u8 *hash,
> +				    unsigned int size),
> +		     int (*get_reh_size)(struct fpga_sec_mgr *smgr),
> +		     char *buf)
> +{
> +	int size, i, cnt, ret;
> +	u8 *hash;
> +
> +	ret =3D get_reh_size(smgr);
> +	if (ret < 0)
> +		return ret;
> +	else if (!ret)
> +		return sysfs_emit(buf, "hash not programmed\n");
> +
> +	size =3D ret;
> +	hash =3D vmalloc(size);
> +	if (!hash)
> +		return -ENOMEM;
> +
> +	ret =3D get_reh(smgr, hash, size);
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
> +	struct fpga_sec_mgr *smgr =3D to_sec_mgr(dev); \
> +	return show_canceled_csk(smgr, \
> +	       smgr->sops->_name##_canceled_csks, \
> +	       smgr->sops->_name##_canceled_csk_nbits, buf); \
> +} \
> +static DEVICE_ATTR_RO(_name##_canceled_csks)
> +
> +#define DEVICE_ATTR_SEC_ROOT_ENTRY_HASH(_name) \
> +static ssize_t _name##_root_entry_hash_show(struct device *dev, \
> +				     struct device_attribute *attr, \
> +				     char *buf) \
> +{ \
> +	struct fpga_sec_mgr *smgr =3D to_sec_mgr(dev); \
> +	return show_root_entry_hash(smgr, \
> +	       smgr->sops->_name##_root_entry_hash, \
> +	       smgr->sops->_name##_reh_size, buf); \
> +} \
> +static DEVICE_ATTR_RO(_name##_root_entry_hash)
> +
> +static ssize_t user_flash_count_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct fpga_sec_mgr *smgr =3D to_sec_mgr(dev);
> +	int cnt =3D smgr->sops->user_flash_count(smgr);
> +
> +	return cnt < 0 ? cnt : sysfs_emit(buf, "%u\n", cnt);
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
> +	((attribute) =3D=3D &dev_attr_##_name.attr && smgr->sops->_name)
> +
> +static umode_t sec_mgr_visible(struct kobject *kobj,
> +			       struct attribute *attr, int n)
> +{
> +	struct fpga_sec_mgr *smgr =3D to_sec_mgr(kobj_to_dev(kobj));
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
> +	struct fpga_sec_mgr *smgr =3D to_sec_mgr(dev);
> +
> +	return sysfs_emit(buf, "%s\n", smgr->name);
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
> +static const struct attribute_group *fpga_sec_mgr_attr_groups[] =3D {
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
> +	if (sysfs_handler && !size_handler) {
> +		dev_err(dev, "%s registered without %s\n",
> +			sysfs_handler_name, size_handler_name);
> +		return false;
> +	} else if (!sysfs_handler && size_handler) {
> +		dev_err(dev, "%s registered without %s\n",
> +			size_handler_name, sysfs_handler_name);
> +		return false;
> +	}
> +	return true;
> +}
> +
> +#define check_reh_handler(_dev, _sops, _name) \
> +	check_sysfs_handler(_dev, (_sops)->_name##_root_entry_hash, \
> +			    (_sops)->_name##_reh_size, \
> +			    __stringify(_name##_root_entry_hash), \
> +			    __stringify(_name##_reh_size))
> +
> +#define check_csk_handler(_dev, _sops, _name) \
> +	check_sysfs_handler(_dev, (_sops)->_name##_canceled_csks, \
> +			    (_sops)->_name##_canceled_csk_nbits, \
> +			    __stringify(_name##_canceled_csks), \
> +			    __stringify(_name##_canceled_csk_nbits))
> +
> +/**
> + * fpga_sec_mgr_create - create and initialize an FPGA
> + *			  security manager struct
> + *
> + * @dev:  fpga security manager device from pdev
> + * @name: fpga security manager name
> + * @sops: pointer to a structure of fpga callback functions
> + * @priv: fpga security manager private data
> + *
> + * The caller of this function is responsible for freeing the struct
> + * with ifpg_sec_mgr_free(). Using devm_fpga_sec_mgr_create() instead
> + * is recommended.
> + *
> + * Return: pointer to struct fpga_sec_mgr or NULL
> + */
> +struct fpga_sec_mgr *
> +fpga_sec_mgr_create(struct device *dev, const char *name,
> +		    const struct fpga_sec_mgr_ops *sops, void *priv)
> +{
> +	struct fpga_sec_mgr *smgr;
> +	int id, ret;
> +
> +	if (!check_reh_handler(dev, sops, bmc) ||
> +	    !check_reh_handler(dev, sops, sr) ||
> +	    !check_reh_handler(dev, sops, pr) ||
> +	    !check_csk_handler(dev, sops, bmc) ||
> +	    !check_csk_handler(dev, sops, sr) ||
> +	    !check_csk_handler(dev, sops, pr)) {
> +		return NULL;
> +	}
> +
> +	if (!name || !strlen(name)) {
> +		dev_err(dev, "Attempt to register with no name!\n");
> +		return NULL;
> +	}
> +
> +	smgr =3D kzalloc(sizeof(*smgr), GFP_KERNEL);
> +	if (!smgr)
> +		return NULL;
> +
> +	id =3D ida_simple_get(&fpga_sec_mgr_ida, 0, 0, GFP_KERNEL);
> +	if (id < 0)
> +		goto error_kfree;
> +
> +	mutex_init(&smgr->lock);
> +
> +	smgr->name =3D name;
> +	smgr->priv =3D priv;
> +	smgr->sops =3D sops;
> +
> +	device_initialize(&smgr->dev);
> +	smgr->dev.class =3D fpga_sec_mgr_class;
> +	smgr->dev.parent =3D dev;
> +	smgr->dev.id =3D id;
> +
> +	ret =3D dev_set_name(&smgr->dev, "fpga_sec%d", id);
> +	if (ret) {
> +		dev_err(dev, "Failed to set device name: fpga_sec%d\n", id);
> +		goto error_device;
> +	}
> +
> +	return smgr;
> +
> +error_device:
> +	ida_simple_remove(&fpga_sec_mgr_ida, id);
> +
> +error_kfree:
> +	kfree(smgr);
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(fpga_sec_mgr_create);
> +
> +/**
> + * fpga_sec_mgr_free - free an FPGA security manager created
> + *			with fpga_sec_mgr_create()
> + *
> + * @smgr:	FPGA security manager structure
> + */
> +void fpga_sec_mgr_free(struct fpga_sec_mgr *smgr)
> +{
> +	ida_simple_remove(&fpga_sec_mgr_ida, smgr->dev.id);
> +	kfree(smgr);
> +}
> +EXPORT_SYMBOL_GPL(fpga_sec_mgr_free);
> +
> +static void devm_fpga_sec_mgr_release(struct device *dev, void *res)
> +{
> +	struct fpga_sec_mgr_devres *dr =3D res;
> +
> +	fpga_sec_mgr_free(dr->smgr);
> +}
> +
> +/**
> + * devm_fpga_sec_mgr_create - create and initialize an FPGA
> + *			       security manager struct
> + *
> + * @dev:  fpga security manager device from pdev
> + * @name: fpga security manager name
> + * @sops: pointer to a structure of fpga callback functions
> + * @priv: fpga security manager private data
> + *
> + * This function is intended for use in a FPGA Security manager
> + * driver's probe function.  After the security manager driver creates
> + * the fpga_sec_mgr struct with devm_fpga_sec_mgr_create(), it should
> + * register it with devm_fpga_sec_mgr_register().
> + * The fpga_sec_mgr struct allocated with this function will be freed
> + * automatically on driver detach.
> + *
> + * Return: pointer to struct fpga_sec_mgr or NULL
> + */
> +struct fpga_sec_mgr *
> +devm_fpga_sec_mgr_create(struct device *dev, const char *name,
> +			 const struct fpga_sec_mgr_ops *sops, void *priv)
> +{
> +	struct fpga_sec_mgr_devres *dr;
> +
> +	dr =3D devres_alloc(devm_fpga_sec_mgr_release, sizeof(*dr),
> GFP_KERNEL);
> +	if (!dr)
> +		return NULL;
> +
> +	dr->smgr =3D fpga_sec_mgr_create(dev, name, sops, priv);
> +	if (!dr->smgr) {
> +		devres_free(dr);
> +		return NULL;
> +	}
> +
> +	devres_add(dev, dr);
> +
> +	return dr->smgr;
> +}
> +EXPORT_SYMBOL_GPL(devm_fpga_sec_mgr_create);
> +
> +/**
> + * fpga_sec_mgr_register - register an FPGA security manager
> + *
> + * @smgr: fpga security manager struct
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +int fpga_sec_mgr_register(struct fpga_sec_mgr *smgr)
> +{
> +	int ret;
> +
> +	ret =3D device_add(&smgr->dev);
> +	if (ret)
> +		goto error_device;
> +
> +	dev_info(&smgr->dev, "%s registered\n", smgr->name);
> +
> +	return 0;
> +
> +error_device:
> +	ida_simple_remove(&fpga_sec_mgr_ida, smgr->dev.id);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(fpga_sec_mgr_register);
> +
> +/**
> + * fpga_sec_mgr_unregister - unregister an FPGA security manager
> + *
> + * @mgr: fpga manager struct
> + *
> + * This function is intended for use in an FPGA security manager
> + * driver's remove() function.
> + */
> +void fpga_sec_mgr_unregister(struct fpga_sec_mgr *smgr)
> +{
> +	dev_info(&smgr->dev, "%s %s\n", __func__, smgr->name);
> +
> +	device_unregister(&smgr->dev);
> +}
> +EXPORT_SYMBOL_GPL(fpga_sec_mgr_unregister);
> +
> +static int fpga_sec_mgr_devres_match(struct device *dev, void *res,
> +				     void *match_data)
> +{
> +	struct fpga_sec_mgr_devres *dr =3D res;
> +
> +	return match_data =3D=3D dr->smgr;
> +}
> +
> +static void devm_fpga_sec_mgr_unregister(struct device *dev, void *res)
> +{
> +	struct fpga_sec_mgr_devres *dr =3D res;
> +
> +	fpga_sec_mgr_unregister(dr->smgr);
> +}
> +
> +/**
> + * devm_fpga_sec_mgr_register - resource managed variant of
> + *				fpga_sec_mgr_register()
> + *
> + * @dev: managing device for this FPGA security manager
> + * @smgr: fpga security manager struct
> + *
> + * This is the devres variant of fpga_sec_mgr_register() for which the
> + * unregister function will be called automatically when the managing
> + * device is detached.
> + */
> +int devm_fpga_sec_mgr_register(struct device *dev, struct fpga_sec_mgr
> *smgr)
> +{
> +	struct fpga_sec_mgr_devres *dr;
> +	int ret;
> +
> +	/*
> +	 * Make sure that the struct fpga_sec_mgr * that is passed in is
> +	 * managed itself.
> +	 */
> +	if (WARN_ON(!devres_find(dev, devm_fpga_sec_mgr_release,
> +				 fpga_sec_mgr_devres_match, smgr)))
> +		return -EINVAL;
> +
> +	dr =3D devres_alloc(devm_fpga_sec_mgr_unregister, sizeof(*dr),
> GFP_KERNEL);
> +	if (!dr)
> +		return -ENOMEM;
> +
> +	ret =3D fpga_sec_mgr_register(smgr);
> +	if (ret) {
> +		devres_free(dr);
> +		return ret;
> +	}
> +
> +	dr->smgr =3D smgr;
> +	devres_add(dev, dr);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(devm_fpga_sec_mgr_register);
> +
> +static void fpga_sec_mgr_dev_release(struct device *dev)
> +{
> +}
> +
> +static int __init fpga_sec_mgr_class_init(void)
> +{
> +	pr_info("FPGA Security Manager\n");
> +
> +	fpga_sec_mgr_class =3D class_create(THIS_MODULE, "fpga_sec_mgr");
> +	if (IS_ERR(fpga_sec_mgr_class))
> +		return PTR_ERR(fpga_sec_mgr_class);
> +
> +	fpga_sec_mgr_class->dev_groups =3D fpga_sec_mgr_attr_groups;
> +	fpga_sec_mgr_class->dev_release =3D fpga_sec_mgr_dev_release;
> +
> +	return 0;
> +}
> +
> +static void __exit fpga_sec_mgr_class_exit(void)
> +{
> +	class_destroy(fpga_sec_mgr_class);
> +	ida_destroy(&fpga_sec_mgr_ida);
> +}
> +
> +MODULE_DESCRIPTION("FPGA Security Manager Driver");
> +MODULE_LICENSE("GPL v2");
> +
> +subsys_initcall(fpga_sec_mgr_class_init);
> +module_exit(fpga_sec_mgr_class_exit)
> diff --git a/include/linux/fpga/fpga-sec-mgr.h b/include/linux/fpga/fpga-=
sec-
> mgr.h
> new file mode 100644
> index 000000000000..dd596c6c3748
> --- /dev/null
> +++ b/include/linux/fpga/fpga-sec-mgr.h
> @@ -0,0 +1,83 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Header file for FPGA Security Manager
> + *
> + * Copyright (C) 2019-2020 Intel Corporation, Inc.
> + */
> +#ifndef _LINUX_FPGA_SEC_MGR_H
> +#define _LINUX_FPGA_SEC_MGR_H
> +
> +#include <linux/device.h>
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +
> +struct fpga_sec_mgr;
> +
> +/**
> + * struct fpga_sec_mgr_ops - device specific operations
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
> +struct fpga_sec_mgr_ops {
> +	int (*user_flash_count)(struct fpga_sec_mgr *smgr);
> +	int (*bmc_root_entry_hash)(struct fpga_sec_mgr *smgr, u8 *hash,
> +				   unsigned int size);
> +	int (*sr_root_entry_hash)(struct fpga_sec_mgr *smgr, u8 *hash,
> +				  unsigned int size);
> +	int (*pr_root_entry_hash)(struct fpga_sec_mgr *smgr, u8 *hash,
> +				  unsigned int size);
> +	int (*bmc_canceled_csks)(struct fpga_sec_mgr *smgr,
> +				 unsigned long *csk_map, unsigned int nbits);
> +	int (*sr_canceled_csks)(struct fpga_sec_mgr *smgr,
> +				unsigned long *csk_map, unsigned int nbits);
> +	int (*pr_canceled_csks)(struct fpga_sec_mgr *smgr,
> +				unsigned long *csk_map, unsigned int nbits);
> +	int (*bmc_reh_size)(struct fpga_sec_mgr *smgr);
> +	int (*sr_reh_size)(struct fpga_sec_mgr *smgr);
> +	int (*pr_reh_size)(struct fpga_sec_mgr *smgr);
> +	int (*bmc_canceled_csk_nbits)(struct fpga_sec_mgr *smgr);
> +	int (*sr_canceled_csk_nbits)(struct fpga_sec_mgr *smgr);
> +	int (*pr_canceled_csk_nbits)(struct fpga_sec_mgr *smgr);
> +};
> +
> +struct fpga_sec_mgr {
> +	const char *name;
> +	struct device dev;
> +	const struct fpga_sec_mgr_ops *sops;
> +	struct mutex lock;		/* protect data structure contents */
> +	void *priv;
> +};
> +
> +struct fpga_sec_mgr *
> +fpga_sec_mgr_create(struct device *dev, const char *name,
> +		    const struct fpga_sec_mgr_ops *sops, void *priv);
> +
> +struct fpga_sec_mgr *
> +devm_fpga_sec_mgr_create(struct device *dev, const char *name,
> +			 const struct fpga_sec_mgr_ops *sops, void *priv);
> +
> +int fpga_sec_mgr_register(struct fpga_sec_mgr *smgr);
> +int devm_fpga_sec_mgr_register(struct device *dev,
> +			       struct fpga_sec_mgr *smgr);
> +void fpga_sec_mgr_unregister(struct fpga_sec_mgr *smgr);
> +void fpga_sec_mgr_free(struct fpga_sec_mgr *smgr);
> +
> +#endif
> --
> 2.25.1

