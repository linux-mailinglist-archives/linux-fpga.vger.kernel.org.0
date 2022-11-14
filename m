Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1AC627DBC
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Nov 2022 13:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237128AbiKNM0S (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Nov 2022 07:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237095AbiKNM0Q (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Nov 2022 07:26:16 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4C722514;
        Mon, 14 Nov 2022 04:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668428775; x=1699964775;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8oUW2ft/RlXaBxOCChtkuLJG81LmMNsJSohcN0UgYgI=;
  b=KvRpdZSUzaLB8Jzmw1XIxbzEI7yFxDmK8rw869HHBFBTcYsEm6ihn9Cw
   TsPEMQcoboSM/Gt6b6k3aeQFX3KFoblZ6wLvY0aJRrkV7MQGiDqE2CF6a
   ifLKZGzqghN0BoatBDDhgK0QuJcMs16ybMWmtqGa3N9v/eXHAjiuofgtc
   9nmhtsdx92zMQ9JUQQ3ioochFZ5Kwv9zrU1cCUuz2UZCMHXGK6H04G9VR
   gDj8yTVbxh0/4oAIW6UydP2ZG+n6ZIUjAkKpe2KTPrjw8dgang5gbKwoY
   fvyevMINfU7SpKA0GDmwvx7SCyRzPPkyhtnnSimg7R+EVqTR+iN0jshEn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="374084590"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="374084590"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 04:26:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="671540617"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="671540617"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 14 Nov 2022 04:26:14 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 04:26:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 04:26:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 14 Nov 2022 04:26:14 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 14 Nov 2022 04:25:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuHW9RwtQvr//rgWqs8zDh+jvFUfrcE4397bW6NW5Ft7xsH/PopUtdPlhKwF6ezFYNpGE9IVYh1PkqYD46Y3qToYW92W/cb7HgsM5A7JWnqE1Hu61dkkDaX13V+1t6pkb2fji2cX55ik96y5raJ2XRr16+CUOVRwfzZ43lYP8AveXFTtpK9U4/Jjqyjl1G9V3jgeGJT0AZYDMLWJhkrsESqUmgTf+kNSOzURALbBhm/hrVVosE+cSsQwjbYssk/gf8vY//z2ecy0T0esOYeX5l2zbaMyOEx7RYlHEoIpvEtqSh7cRkG+XLB8KrpaaYneADBZB2LULLgUzNC2NntLAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inc8qFg9aELiRmUnya0SDvuHSY/6qa8lKI1tX3jHel4=;
 b=iTmWbCdwDiVI/4AtLYXoPlhvtAMD7vlbIt7ujlehjaCj7/xXGERr3t79Wh/1itqt3A8UFG87nK+CVLpj7ro+tqOM7hZgvZOpSLsFj/QtCoH0wgTKBkhC5+XnSHvBPqWm7QazqDij/ZkgUEZ0tQ+BgQrm9HVWvjk4lRCPeQ3lZdpyLZtF3h27cws+EdRA3VO7Q3Vibutnn2m0FcblTJs75fx7pJKmtwcyhThMxauTDXuAp8wTWQVc/7dWfmWPfyUXwh1Rbm2kslDAXudK2H/dS2wkkwy1MurueE5e8DAW5Z0PWniOsRoRI4Cw1vOeUL9DevDInl7Dhq25n3Vibmbdtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by CY8PR11MB6986.namprd11.prod.outlook.com (2603:10b6:930:56::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 12:25:56 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::3f62:3295:adf5:aaae]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::3f62:3295:adf5:aaae%5]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 12:25:56 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "Wu, Hao" <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 10/12] mfd: intel-m10-bmc: Add PMCI driver
Thread-Topic: [PATCH 10/12] mfd: intel-m10-bmc: Add PMCI driver
Thread-Index: AQHY84CTMyqV10wI6ky0gnImMGtbNK45gt6AgATeVhA=
Date:   Mon, 14 Nov 2022 12:25:56 +0000
Message-ID: <BN9PR11MB5483C15CCD0664764E536F43E3059@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20221108144305.45424-1-ilpo.jarvinen@linux.intel.com>
 <20221108144305.45424-11-ilpo.jarvinen@linux.intel.com>
 <Y24eF6OsRTFGcB/F@yilunxu-OptiPlex-7050>
In-Reply-To: <Y24eF6OsRTFGcB/F@yilunxu-OptiPlex-7050>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5483:EE_|CY8PR11MB6986:EE_
x-ms-office365-filtering-correlation-id: 306f3540-4472-4a53-c75c-08dac63b6180
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pxR43azJNq6sSRN31NcuuWt2NGaoBxvphoU26g4g8uy509xyZyLdmqLmwvQekuo6BMgvhdpnLKlJ37rKOZyawUzDMI3u2gglcEBPRRlmtYlgfHS/S2DuQH3MYsuT8uGkVPrEv74FwbBJtCUKVODBOu9D6v6SXPvfHuvEkXUjmU/6EFqpo6mptdiuS5uypavTT3JjT+BZDcDYYfGug1u8jRMkTJJQrzlFOiUfYEiYDI1ZLzF+y17htvPhsbINJNbWxEovCvinqtIm6eadd0su56yeACayrZf03gsWL2pno9C+VCT4loJcfcrWwr8ThfPhxG7sTAquPJdp29hKB8HfNpkAzA1M9awGI2jUvJTI2twUW1n/Lip2OAyN7DR+h91zi57U9nqucY4yXIlEGHvhYJ8hbKAe4fIKrGeTP/gEjNFMVzSs8427BeW/WsE5gixZeH5l6rWxrONoSY1fL2VGpIJcwd3xralapXJ4e2Yil3yUCM+k2NMjvxJwogkNmyT45Z2PKpYdFBTd3QnxwTAeDxLyEKYv/JqN9ZxklJX8eFegRNUQtRdFGrD+tLBewJmQhnmm7uO0yd59JXls5fe2tETeseATLyyJ3dCLRR2fKlLdoPCusH34u6r+OYb9nYSdNw+tqjFpn0jflMMUGJMpf2IZ4uxucLbC8WglG7jan1cGspQWyNdDJbqAfjWluBwjisUm0ry8aZOmfpb2PszCS34t0BuPzj6nthNcqiKkNrodHr8l0lUz8M5ElnY7J73onwG+JpWJJdVmlo4GDalBOXDM/HqKrK9+PnH+s4k3bqE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199015)(9686003)(66556008)(66946007)(86362001)(82960400001)(76116006)(316002)(66476007)(66446008)(53546011)(64756008)(55016003)(66574015)(83380400001)(2906002)(33656002)(41300700001)(38100700002)(4326008)(186003)(8676002)(122000001)(5660300002)(8936002)(52536014)(966005)(71200400001)(478600001)(110136005)(6506007)(7696005)(54906003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2bRPKYEwcGuYKlvT1DFzhDkpI2WTj7NAei8IUf9LpRdpaBCDVYcfgWTlwI?=
 =?iso-8859-1?Q?rjFlFiEHW/u6TstIKIqR4laoe+68uQXX4Gkf1BQC3H14IrllM1E7hgxynI?=
 =?iso-8859-1?Q?tefafptlCIFscWjRxR+RTOJDkDqLOM0sGqY4Q4AhkwJtFUSvlyqVtecmnv?=
 =?iso-8859-1?Q?63v4CaL3ofL0BPaj/oP1dfJr+5P6VYkIl51JeoGpbiOY5cytLtGGm4E1T+?=
 =?iso-8859-1?Q?hriRmHX4ZPM0KHtpC3PfK5P5SAiG6MOI7pZ+UNs2Nnfj81Ehhaxd8jvyYj?=
 =?iso-8859-1?Q?3Y0piMhTnMcwWx1/uSTN7o3cfW/UnnI6AmIPG6IApqAnpNmhOYzm5QmJJI?=
 =?iso-8859-1?Q?ZTlV7rnOoW6+vo7kxkFuXfGKpslGusaEHWvweWsY0C++1i+2H/zmqzJtRU?=
 =?iso-8859-1?Q?YQO/nIvjDotpyJwzoYld/6c/cIZ7rTTmQkgSKmFwbFyxxv9LSCSLDLfm07?=
 =?iso-8859-1?Q?+oDmjmBK8PqQwOKKFp60AIKajrYypfHx7xPGha52Kr5u7GvpvLsYU1uJMo?=
 =?iso-8859-1?Q?EmmRuh+Jf8l1IUD7byQHtBR6uPqYtwE/c+smGWQ5yPyLGYhYYzAyquX7X2?=
 =?iso-8859-1?Q?U42wSqNFZ9rrmb45NJKjQsPDTy8xazqodlhk+njJXVUlGFRpEzmXcSn+c0?=
 =?iso-8859-1?Q?P6hkdb24cz08wRV8l4FmNQE9KzdcQpsRGaT7RHkGH/r95rzh4b2nuupyLM?=
 =?iso-8859-1?Q?Xj8KDTTf5evcYMxNqhM+jc7T/P2nOuw5M4uCZew3a+BhYPSerMIioeytCu?=
 =?iso-8859-1?Q?xbQBO7XYWBbsjk4I0+nZJvWs1Ogm+AYo/UvOidMT57UdEUMERpgTrjdKxn?=
 =?iso-8859-1?Q?7hSkXMB7O1dlYGab1RyRMpy15S5+Fwdq/cguiWq1juzm6XetTPjmyyhWgH?=
 =?iso-8859-1?Q?u4I5XDqTgwUazQCEdNcUPkBUA/sLGOInaSHZv8cu+i6LCx/HxC6k+qsYEv?=
 =?iso-8859-1?Q?5FgY0tPf8r51lXZUIdysiDZBncFOTFhQePWOfiUJMOLAXD8dgg5dX84lWM?=
 =?iso-8859-1?Q?JceH24kAYxAt2b9nx82HWdRskQwHXaiDklpQVmeZ2+t+fJXF0L8sPZCiyW?=
 =?iso-8859-1?Q?FGRvwLte42ihAOOMhQEU0fFMeXTR+X6gjKMzmu5wtgbcTqCLyf9tytYUEt?=
 =?iso-8859-1?Q?paS/9D+5YrCKKHThL8HTfSY0VLOey4jdFwcxPQvIKR4bHoW3Q35GDr2OyJ?=
 =?iso-8859-1?Q?SYwkwsTu4/vHP2FvDlG8MQCYU1nel6CBYaMs+zRFpUwSPfv/Nnk7bRzrrg?=
 =?iso-8859-1?Q?6M+FcPXDjFZZw/Ejw58Ykw4yi//oPsDCN0JFEjFSo1ELRNPWV9qZBDey+P?=
 =?iso-8859-1?Q?m7Fx+KV6QYSFwaiXDuYL0zeobcySUR1idklDufm+Bc7KqGQLx2lV/izBDx?=
 =?iso-8859-1?Q?rOPMl4i0Xb09QsirHfq5JcNDj8wnGA16QIDqw+m8SpESHmKvXoPg45wnkX?=
 =?iso-8859-1?Q?4b3TPkRQoVS/UL+zI4dk4xXZmMx+DMSvtHf2PNvpxWaPKM8RA/bCkvK9T2?=
 =?iso-8859-1?Q?aP1gIGxWgeHON0IRDoxwOMX/ek8jXPA+oImEwSwmWP/xh3KhGJ5E3yNTM1?=
 =?iso-8859-1?Q?bmt7nYCLFPyPs92mA14ch4I5+w1UXxAs2Kodeaj1hZ2jmMcJ2StiMbAe/4?=
 =?iso-8859-1?Q?ZxP3hJtro8LRqd5Gwzzgua+/1VAoq+OhMzkUsBvNP2ICZZbMH30n36M83o?=
 =?iso-8859-1?Q?K8Ie4heKJ6DF+TIetlsLVigiVS5+rFSl2+OdGx0z?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 306f3540-4472-4a53-c75c-08dac63b6180
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 12:25:56.6921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UVq/rjlBCqXabG5TqDw1oV0/pX47SGvynXf/3ZYAFLkRPCPPqvsF6qwzBZ/KAJSKG/m+xLyUtSx/8PkBG9wUdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6986
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



> -----Original Message-----
> From: Xu, Yilun <yilun.xu@intel.com>
> Sent: Friday, November 11, 2022 6:04 PM
> To: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Cc: linux-fpga@vger.kernel.org; Wu, Hao <hao.wu@intel.com>; Tom Rix
> <trix@redhat.com>; Moritz Fischer <mdf@kernel.org>; Lee Jones <lee@kernel=
.org>;
> Matthew Gerlach <matthew.gerlach@linux.intel.com>; Weight, Russell H
> <russell.h.weight@intel.com>; Zhang, Tianfei <tianfei.zhang@intel.com>; M=
ark
> Brown <broonie@kernel.org>; Greg KH <gregkh@linuxfoundation.org>; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 10/12] mfd: intel-m10-bmc: Add PMCI driver
>=20
> On 2022-11-08 at 16:43:03 +0200, Ilpo J=E4rvinen wrote:
> > Adding an mfd driver for the PMCI-based interface of Intel MAX10 BMC
> > controller.
>=20
> Could you help describe what is PMCI? Also add the description somewhere =
in code.

This patch has a brief introduction of PMCI.
https://patchwork.kernel.org/project/linux-fpga/patch/20220624092229.45854-=
3-tianfei.zhang@intel.com/

>=20
> >
> > Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
> > Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> > Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  .../ABI/testing/sysfs-driver-intel-m10-bmc    |   8 +-
> >  drivers/mfd/Kconfig                           |  12 ++
> >  drivers/mfd/Makefile                          |   1 +
> >  drivers/mfd/intel-m10-bmc-pmci.c              | 154 ++++++++++++++++++
> >  include/linux/mfd/intel-m10-bmc.h             |   1 +
> >  5 files changed, 172 insertions(+), 4 deletions(-)  create mode
> > 100644 drivers/mfd/intel-m10-bmc-pmci.c
> >
> > diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
> > b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
> > index 9773925138af..a8ab58035c95 100644
> > --- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
> > +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
> > @@ -1,4 +1,4 @@
> > -What:		/sys/bus/spi/devices/.../bmc_version
> > +What:		/sys/bus/.../drivers/intel-m10-bmc/.../bmc_version
>=20
> It's good. And could you add in commit message about why the changes to t=
he ABI
> description.
>=20
> >  Date:		June 2020
> >  KernelVersion:	5.10
> >  Contact:	Xu Yilun <yilun.xu@intel.com>
> > @@ -6,7 +6,7 @@ Description:	Read only. Returns the hardware build
> version of Intel
> >  		MAX10 BMC chip.
> >  		Format: "0x%x".
> >
> > -What:		/sys/bus/spi/devices/.../bmcfw_version
> > +What:		/sys/bus/.../drivers/intel-m10-bmc/.../bmcfw_version
> >  Date:		June 2020
> >  KernelVersion:	5.10
> >  Contact:	Xu Yilun <yilun.xu@intel.com>
> > @@ -14,7 +14,7 @@ Description:	Read only. Returns the firmware version =
of
> Intel MAX10
> >  		BMC chip.
> >  		Format: "0x%x".
> >
> > -What:		/sys/bus/spi/devices/.../mac_address
> > +What:		/sys/bus/.../drivers/intel-m10-bmc/.../mac_address
> >  Date:		January 2021
> >  KernelVersion:  5.12
> >  Contact:	Russ Weight <russell.h.weight@intel.com>
> > @@ -25,7 +25,7 @@ Description:	Read only. Returns the first MAC address=
 in
> a block
> >  		space.
> >  		Format: "%02x:%02x:%02x:%02x:%02x:%02x".
> >
> > -What:		/sys/bus/spi/devices/.../mac_count
> > +What:		/sys/bus/.../drivers/intel-m10-bmc/.../mac_count
> >  Date:		January 2021
> >  KernelVersion:  5.12
> >  Contact:	Russ Weight <russell.h.weight@intel.com>
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig index
> > a09d4ac60dc7..38d53f6c4d7b 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -2238,6 +2238,18 @@ config MFD_INTEL_M10_BMC_SPI
> >            additional drivers must be enabled in order to use the funct=
ionality
> >            of the device.
> >
> > +config MFD_INTEL_M10_BMC_PMCI
> > +	tristate "Intel MAX 10 Board Management Controller with PMCI"
> > +	depends on FPGA_DFL
> > +	select MFD_INTEL_M10_BMC_CORE
> > +	select REGMAP_INDIRECT
> > +	help
> > +	  Support for the Intel MAX 10 board management controller via PMCI.
> > +
> > +	  This driver provides common support for accessing the device,
> > +	  additional drivers must be enabled in order to use the functionalit=
y
> > +	  of the device.
> > +
> >  config MFD_RSMU_I2C
> >  	tristate "Renesas Synchronization Management Unit with I2C"
> >  	depends on I2C && OF
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile index
> > f32276cdd0c2..7559362cb438 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -275,6 +275,7 @@ obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+=3D simple-mfd-
> i2c.o
> >  intel-m10-bmc-objs             :=3D intel-m10-bmc-core.o
> >  obj-$(CONFIG_MFD_INTEL_M10_BMC_CORE)   +=3D intel-m10-bmc.o
> >  obj-$(CONFIG_MFD_INTEL_M10_BMC_SPI)   +=3D intel-m10-bmc-spi.o
> > +obj-$(CONFIG_MFD_INTEL_M10_BMC_PMCI)  +=3D intel-m10-bmc-pmci.o
> >
> >  obj-$(CONFIG_MFD_ATC260X)	+=3D atc260x-core.o
> >  obj-$(CONFIG_MFD_ATC260X_I2C)	+=3D atc260x-i2c.o
> > diff --git a/drivers/mfd/intel-m10-bmc-pmci.c
> > b/drivers/mfd/intel-m10-bmc-pmci.c
> > new file mode 100644
> > index 000000000000..918378a78bdb
> > --- /dev/null
> > +++ b/drivers/mfd/intel-m10-bmc-pmci.c
> > @@ -0,0 +1,154 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PMCI-based interface to MAX10 BMC
> > + *
> > + * Copyright (C) 2020-2022 Intel Corporation, Inc.
> > + *
> > + */
> > +
> > +#include <linux/dfl.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/mfd/intel-m10-bmc.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +
> > +#define M10BMC_PMCI_INDIRECT_BASE	0x400
> > +
> > +#define M10BMC_PMCI_SYS_BASE		0x0
> > +#define M10BMC_PMCI_SYS_END		0xfff
> > +
> > +#define M10BMC_PMCI_DOORBELL		0x1c0
> > +#define M10BMC_PMCI_AUTH_RESULT		0x1c4
> > +
> > +/* Telemetry registers */
> > +#define M10BMC_PMCI_TELEM_START		0x400
> > +#define M10BMC_PMCI_TELEM_END		0x78c
> > +
> > +#define M10BMC_PMCI_BUILD_VER		0x0
> > +#define NIOS2_PMCI_FW_VERSION		0x4
> > +#define M10BMC_PMCI_MAC_LOW		0x20
> > +#define M10BMC_PMCI_MAC_HIGH		(M10BMC_PMCI_MAC_LOW + 4)
> > +
> > +/* Addresses for security related data in FLASH */
> > +#define PMCI_BMC_REH_ADDR		0x7ffc004
> > +#define PMCI_BMC_PROG_ADDR		0x7ffc000
> > +#define PMCI_BMC_PROG_MAGIC		0x5746
> > +
> > +#define PMCI_SR_REH_ADDR		0x7ffd004
> > +#define PMCI_SR_PROG_ADDR		0x7ffd000
> > +#define PMCI_SR_PROG_MAGIC		0x5253
> > +
> > +#define PMCI_PR_REH_ADDR		0x7ffe004
> > +#define PMCI_PR_PROG_ADDR		0x7ffe000
> > +#define PMCI_PR_PROG_MAGIC		0x5250
> > +
> > +#define PMCI_STAGING_FLASH_COUNT	0x7ff5000
> > +
> > +struct pmci_device {
> > +	void __iomem *base;
> > +	struct device *dev;
> > +	struct intel_m10bmc m10bmc;
> > +};
> > +
> > +static const struct regmap_range m10bmc_pmci_regmap_range[] =3D {
> > +	regmap_reg_range(M10BMC_PMCI_SYS_BASE, M10BMC_PMCI_SYS_END),
> };
> > +
> > +static const struct regmap_access_table m10_access_table =3D {
> > +	.yes_ranges	=3D m10bmc_pmci_regmap_range,
> > +	.n_yes_ranges	=3D ARRAY_SIZE(m10bmc_pmci_regmap_range),
> > +};
> > +
> > +static const struct regmap_indirect_cfg indirect_cfg =3D {
> > +	INTEL_M10_REGMAP_INDIRECT_CFG,
> > +};
> > +
> > +static struct regmap_config m10bmc_pmci_regmap_config =3D {
> > +	.reg_bits =3D 32,
> > +	.reg_stride =3D 4,
> > +	.val_bits =3D 32,
> > +	.wr_table =3D &m10_access_table,
> > +	.rd_table =3D &m10_access_table,
> > +	.max_register =3D M10BMC_PMCI_SYS_END,
> > +	.indirect_cfg =3D &indirect_cfg,
> > +};
> > +
> > +static struct mfd_cell m10bmc_n6000_bmc_subdevs[] =3D {
> > +	{ .name =3D "n6000bmc-hwmon" },
> > +};
> > +
> > +static const struct m10bmc_csr_map m10bmc_pmci_csr_map =3D {
> > +	.base =3D M10BMC_PMCI_SYS_BASE,
> > +	.build_version =3D M10BMC_PMCI_BUILD_VER,
> > +	.fw_version =3D NIOS2_PMCI_FW_VERSION,
> > +	.mac_low =3D M10BMC_PMCI_MAC_LOW,
> > +	.mac_high =3D M10BMC_PMCI_MAC_HIGH,
> > +	.doorbell =3D M10BMC_PMCI_DOORBELL,
> > +	.auth_result =3D M10BMC_PMCI_AUTH_RESULT,
> > +	.bmc_prog_addr =3D PMCI_BMC_PROG_ADDR,
> > +	.bmc_reh_addr =3D PMCI_BMC_REH_ADDR,
> > +	.bmc_magic =3D PMCI_BMC_PROG_MAGIC,
> > +	.sr_prog_addr =3D PMCI_SR_PROG_ADDR,
> > +	.sr_reh_addr =3D PMCI_SR_REH_ADDR,
> > +	.sr_magic =3D PMCI_SR_PROG_MAGIC,
> > +	.pr_prog_addr =3D PMCI_PR_PROG_ADDR,
> > +	.pr_reh_addr =3D PMCI_PR_REH_ADDR,
> > +	.pr_magic =3D PMCI_PR_PROG_MAGIC,
> > +	.rsu_update_counter =3D PMCI_STAGING_FLASH_COUNT, };
> > +
> > +static const struct intel_m10bmc_platform_info m10bmc_m10_n6000 =3D {
> > +	.type =3D M10_N6000,
> > +	.cells =3D m10bmc_n6000_bmc_subdevs,
> > +	.n_cells =3D ARRAY_SIZE(m10bmc_n6000_bmc_subdevs),
> > +	.csr_map =3D &m10bmc_pmci_csr_map,
> > +};
> > +
> > +static int pmci_probe(struct dfl_device *ddev) {
> > +	struct device *dev =3D &ddev->dev;
> > +	struct pmci_device *pmci;
> > +
> > +	pmci =3D devm_kzalloc(dev, sizeof(*pmci), GFP_KERNEL);
> > +	if (!pmci)
> > +		return -ENOMEM;
> > +
> > +	pmci->m10bmc.dev =3D dev;
> > +	pmci->dev =3D dev;
>=20
> I don't see its usage.
>=20
> > +
> > +	pmci->base =3D devm_ioremap_resource(dev, &ddev->mmio_res);
> > +	if (IS_ERR(pmci->base))
> > +		return PTR_ERR(pmci->base);
> > +
> > +	pmci->m10bmc.regmap =3D
> > +		devm_regmap_init_indirect(dev,
> > +					  pmci->base +
> M10BMC_PMCI_INDIRECT_BASE,
> > +					  &m10bmc_pmci_regmap_config);
> > +	if (IS_ERR(pmci->m10bmc.regmap))
> > +		return PTR_ERR(pmci->m10bmc.regmap);
> > +
> > +	return m10bmc_dev_init(&pmci->m10bmc, &m10bmc_m10_n6000); }
> > +
> > +#define FME_FEATURE_ID_PMCI_BMC	0x12
> > +
> > +static const struct dfl_device_id pmci_ids[] =3D {
> > +	{ FME_ID, FME_FEATURE_ID_PMCI_BMC },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(dfl, pmci_ids);
> > +
> > +static struct dfl_driver pmci_driver =3D {
> > +	.drv	=3D {
> > +		.name       =3D "intel-m10-bmc",
> > +		.dev_groups =3D m10bmc_dev_groups,
> > +	},
> > +	.id_table =3D pmci_ids,
> > +	.probe    =3D pmci_probe,
> > +};
> > +
> > +module_dfl_driver(pmci_driver);
>=20
> Maybe change the name. This is still a MAX10 bmc driver, pmci is just the=
 interface to
> max10.
>=20
> Thanks,
> Yilun
>=20
> > +
> > +MODULE_DESCRIPTION("MAX10 BMC PMCI-based interface");
> > +MODULE_AUTHOR("Intel Corporation"); MODULE_LICENSE("GPL");
> > diff --git a/include/linux/mfd/intel-m10-bmc.h
> > b/include/linux/mfd/intel-m10-bmc.h
> > index 1b907c1a176f..90f2a691ef46 100644
> > --- a/include/linux/mfd/intel-m10-bmc.h
> > +++ b/include/linux/mfd/intel-m10-bmc.h
> > @@ -13,6 +13,7 @@ enum m10bmc_type {
> >  	M10_N3000,
> >  	M10_D5005,
> >  	M10_N5010,
> > +	M10_N6000,
> >  };
> >
> >  #define INTEL_M10_REGMAP_INDIRECT_CFG	\
> > --
> > 2.30.2
> >
