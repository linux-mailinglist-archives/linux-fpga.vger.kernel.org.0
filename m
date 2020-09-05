Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB6E25E849
	for <lists+linux-fpga@lfdr.de>; Sat,  5 Sep 2020 16:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgIEONm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 5 Sep 2020 10:13:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:7518 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgIEONl (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 5 Sep 2020 10:13:41 -0400
IronPort-SDR: Jc/N2AXq59bGBw29aCQ/5EwDttu75wXe9GxkmpLX+n6OlBM1M35x0E38GK9C4pRWy+B54nCpYW
 dReaFla/334A==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="155265018"
X-IronPort-AV: E=Sophos;i="5.76,394,1592895600"; 
   d="scan'208";a="155265018"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2020 07:13:40 -0700
IronPort-SDR: VWtPjrnJh1Y+OnzKl9a3PbxL1rx31ZdxvBQ+1KeByruhYLohTu20nXxQQ5Czoc/JtSQOxDe01d
 oeUCnX7FSijQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,394,1592895600"; 
   d="scan'208";a="284819116"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 05 Sep 2020 07:13:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 5 Sep 2020 07:13:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 5 Sep 2020 07:13:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 5 Sep 2020 07:13:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sat, 5 Sep 2020 07:13:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UA/QzwgM5j4/NZu1BuSlLGr6synHMA3ApJp57pUPIvWqO9KQP9vCufXH0UxXbeBBvEf8isWQodnXOqETAOqVzWD/cRZfXG5kuyGB3VfFgnCTe9hyGA2c0KnWk7m4DYX5h3yf8T4htuy6bvXlPWFyV+jgNvpCHR1YsArH+qiGq3kAYNS9bWbTcBThvep3mkXj4DMjvazwIj0QPEw5SOQnIXubm493dixZE+yvbQFBgacCsRqAza9c7ezczjECa+nZ0MPPKiNcgz98SUcwmjqwFxj7LfXr3ieQr4mX3yRHZNCaQ89YU3eev4ssfHIx7QqNesVOO+L2Cr7eWC+n2jnPvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uA/Kke5+qzMoE83GapssNDTQwYJzbM3IRxzk8E9v6Y8=;
 b=LmevT3NTKJbPyCrUy9/YET4F7DB8LLuK32L8KKsMrcqUH9NpbGsaKi+fKvkAIkKiY57MIQTajMaxXZjkcuAbhJjRYYIEWqJ7cB1COQ/qem9+jyolRM1XI5+aX+20jIxe/2IDhyEE7WwlPnV2ag+yXyPvEz9HqFthUiM7m3qzSci6mb+gslVzbE7Pi61ff31LVobV5B+ny8rQQeUYEby/J2pK+oUx13sz9V4l95aVnt8/pQYkcDN4nSX3z2NosXvKDHrLSxK1KDOh0VaPU54YO/14u2Yym4+nuif/K6wJjtJRjlF4CjkkoB0DL9htLVqPexmOTe93OdKcVQujFHg4iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uA/Kke5+qzMoE83GapssNDTQwYJzbM3IRxzk8E9v6Y8=;
 b=B957L+tJAOwLgImUjQYvQG1KyPAT3ao5V+7cVz/RB0erMlmRydY7K8vD3kOuMQUJ1iLHS02DzXy9RYtzyo9P001eR75j0FMiDy9IX+5S2G7oapW8O7qPE3JX4e0ovn3IZBtXZUJWi2R8t1lwJx5Ic9DlAUg8awplFPEePUVWSUE=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3820.namprd11.prod.outlook.com (2603:10b6:5:140::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.17; Sat, 5 Sep
 2020 14:13:14 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7823:516e:1ec4:a60d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7823:516e:1ec4:a60d%5]) with mapi id 15.20.3348.017; Sat, 5 Sep 2020
 14:13:14 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Weight, Russell H" <russell.h.weight@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>
Subject: RE: [PATCH v1 00/12] Intel FPGA Security Manager Class Driver
Thread-Topic: [PATCH v1 00/12] Intel FPGA Security Manager Class Driver
Thread-Index: AQHWgxgQpWSE/ewYT0qNmW7SyBgTh6laDZzA
Date:   Sat, 5 Sep 2020 14:13:13 +0000
Message-ID: <DM6PR11MB38198EC62FA2C63B3E5BC8D0852A0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20200904235305.6254-1-russell.h.weight@intel.com>
In-Reply-To: <20200904235305.6254-1-russell.h.weight@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e583869d-2fa9-42c0-62d3-08d851a5d426
x-ms-traffictypediagnostic: DM6PR11MB3820:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB382049218338C58DBE6EE090852A0@DM6PR11MB3820.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pVxwF0Wjpb3WZgrALAmAcpjAdeS17XLzeZVd1D20pU0xyTS9qCTyerll+lpolsgph3/8ZL3A2BGZ8viRO4g3lHS+tJQkbe1/+OiMILPQWEq2vh3V0yqwsGw4WpcGMr09z2tYSvO4ZxFEIk1V8tYsV7cN7wkb41B4dIiNWTWYI3yQ06XC5HfHyYcE+3QQmFBdl9qYGiiEidN1yY0XErXmGIdf114E1iYtZJD6Y0PYT/Ane/hKYMmurXI8kdcQ3ry82svEwOY5a2Id5OwRVIOhBazK/NL0jik/SzF8J5GunqRqHl08ImMtDExXJU77XXo1R/IZs/S7Z5Sfp+ZcNprvgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(478600001)(26005)(54906003)(66476007)(15650500001)(55016002)(8936002)(71200400001)(4326008)(66446008)(66556008)(64756008)(52536014)(76116006)(86362001)(110136005)(107886003)(66946007)(83380400001)(8676002)(186003)(33656002)(9686003)(7696005)(316002)(5660300002)(2906002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 9R/2vAtmckNhzI1ND556N9teSvo/oxZXLlbAJc/53BW7BwJTmL+QxOtbaeZN3/JF95cuv0/2p+3Vl1ofa+FAjgYavisxi2Md2Jvha2c5qIKgRjIs2mmAtFHv7UZlQR9gvI4H9MtdjiPls5NfJ1SRrfJ6JMW+Sq0yaePcEJViiHNJCw8M8yP7x3L/W8aaq2JtF5nCXfejMCr4uv1AU+Fr7+LU5ytvqITRZXlEWve/p/gVRXQSUK7as2IuGaNfT7jBiq664EXjlMwwtINKwPAdh6Jum94SE8cwcyTHeA6z6K408CMoMw+0gXZ8L7voN+sYf/mvYyq05smqQHiTcK+3cCls6aaZvHadQcuYEREhnaqXoxNbD/xNT7StUTxTCwa3dsmEwCrEBNlB45vUbdGwHr6AVeHSR0vJ/VVO8rCckMJxBDs30CrD7xPvn7+gCaawNo7UTAwk6s+OEBjI7NIQ3kXYlM+dDSFAxkPaBzKzYUISj8niPKBaYwnHO1YMR3V0RTbluGiWpWshfv41P8sYCfjoJZazTm/ZxaW7CxiphH7lM0QFyvDATURPlgwmMsk+Udxo3BOinAJ6Z8B6RCxfKsRSkO2yfp+v5P0CF1bh4AMUn7BaFHpRPgpwgYWo3qh51aGS/wAgKdGt389dIHqI4w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e583869d-2fa9-42c0-62d3-08d851a5d426
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2020 14:13:14.0106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BRc1dh6ejX+VG8pqWzmdwpjW6SdzjZ0y+HpKnuJtbb7LMn4WOMT04Hu7cEtSW/1r1sB4v1p7mIOBNaBLrGRu7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3820
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v1 00/12] Intel FPGA Security Manager Class Driver
>=20
>=20
> These patches depend on the patchset: "add regmap-spi-avmm & Intel
> Max10 BMC chip support" which is currently under review.
>=20
>            --------------------------------------------------
>=20
> This patchset introduces the Intel Security Manager class driver
> for managing secure updates on Intel FPGA Cards. It also provides
> the n3000bmc-secure mfd sub-driver for the MAX10 BMC for the n3000
> Programmable Acceleration Cards (PAC). The n3000bmc-secure driver
> is implemented using the Intel Security Manager class driver.

So this patchset contains two parts
(1) adding a new class driver for Intel FPGA secure update.
(2) a new driver which uses (1) to implement secure update for n3000 PAC.

And only part (2) depends on "Intel MAX10 BMC chip support" patchset.
(Maybe you can provide a link to that thread).=20

Is my understanding correct? If yes, is it possible to reorder these patche=
s?
At least there is no dependency on the class driver patches, right?

>=20
> The Intel Security Manager class driver provides a common API for
> user-space tools to manage updates for Secure FPGA devices. Device
> drivers that instantiate the Intel Security Manager class driver will
> interact with the HW secure update engine in order to transfer
> new FPGA and BMC images to FLASH so that they will be automatically
> loaded when the FPGA card reboots.
>=20
> The API consists of sysfs nodes and supports the following functions:
>=20
> (1) Instantiate and monitor a secure update
> (2) Display security information including: Root Entry Hashes (REH),
>     Cancelled Code Signing Keys (CSK), and flash update counts for
>     both BMC and FPGA images.
>=20
> Secure updates make use of the request_firmware framework, which
> requires that image files are accessible under /lib/firmware. A request
> for a secure update returns immediately, while the update itself
> proceeds in the context of a kernel worker thread. Sysfs files provide
> a means for monitoring the progress of a secure update and for
> retrieving error information in the event of a failure.

Maybe you can explain a little more on why we need to have this done
via a class driver not just some internal code in max10 driver? This class
driver will be reused in different cases? And why adding a new class
driver not just reuse or extend fpga manager (existing fpga mgr is used
to update fpga too).

>=20
> The n3000bmc-secure driver instantiates the Intel Security Manager
> class driver and provides the callback functions required to support
> secure updates on Intel n3000 PAC devices.
>=20
> Russ Weight (12):
>   fpga: fpga security manager class driver

Intel FPGA Security Manager?

>   fpga: create intel max10 bmc security engine
>   fpga: expose max10 flash update counts in sysfs
>   fpga: expose max10 canceled keys in sysfs
>   fpga: enable secure updates
>   fpga: add max10 secure update functions
>   fpga: expose sec-mgr update status
>   fpga: expose sec-mgr update errors
>   fpga: expose sec-mgr update size
>   fpga: enable sec-mgr update cancel
>   fpga: expose hardware error info in sysfs

For these patches, is it possible to have a better title for these patches.
Then it will be easier to know which component this patch is going to modif=
y.
e.g. fpga: ifpga-sec-mgr: xxxxxx

Thanks
Hao

>   fpga: add max10 get_hw_errinfo callback func
>=20
>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 151 ++++
>  MAINTAINERS                                   |   8 +
>  drivers/fpga/Kconfig                          |  20 +
>  drivers/fpga/Makefile                         |   6 +
>  drivers/fpga/ifpga-sec-mgr.c                  | 669 ++++++++++++++++++
>  drivers/fpga/intel-m10-bmc-secure.c           | 557 +++++++++++++++
>  include/linux/fpga/ifpga-sec-mgr.h            | 201 ++++++
>  include/linux/mfd/intel-m10-bmc.h             | 116 +++
>  8 files changed, 1728 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>  create mode 100644 drivers/fpga/ifpga-sec-mgr.c
>  create mode 100644 drivers/fpga/intel-m10-bmc-secure.c
>  create mode 100644 include/linux/fpga/ifpga-sec-mgr.h
>=20
> --
> 2.17.1

