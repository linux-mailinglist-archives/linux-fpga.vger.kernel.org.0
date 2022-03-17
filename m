Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E87B4DC173
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Mar 2022 09:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiCQIhp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Mar 2022 04:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiCQIho (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 17 Mar 2022 04:37:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449091B989E;
        Thu, 17 Mar 2022 01:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647506187; x=1679042187;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jf3cycBY4b9bAa1z4+DQe7hnOaypKuYYrMB41iTWVvE=;
  b=QXtw5QGivTKgHD5zqAHWVO3NLIvzylUL64xy4iTDtEoZ2t/YkKwZXFw8
   Yk66i7OUqTmdiC61ICs0UzZJbHitosc+SdHD7VKvOMJiyqRN1WtvhZIWJ
   bC336QzVwi++cpVdnbMkNY5QnEd44lH3CnEhR5wSBO7l8N0vFheSSO64e
   chJZ4MhI2A7pNheXo0xZuttJY+LuUE39MVTMK3bpt5nLuVGhPBgmTRP1N
   CO+mzaV970Y7NkHionWXg9Icem4/45vd7ZnuP5/qXuyObtWpZW0FLKNVb
   +Sf+m9LGVIrCPzb8gWe60Wt/AbzbdvB2xYHTt2YAIxzEB5fX9uxOmzTgk
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="256767267"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="256767267"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 01:36:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="498753607"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga003.jf.intel.com with ESMTP; 17 Mar 2022 01:36:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 01:36:26 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 01:36:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 17 Mar 2022 01:36:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 17 Mar 2022 01:36:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NO1VsK2GlEcN9df1VhFF8WSKdXfeK3PsacXcAH5ctcY69WbRRX2+SNXw9lvmlfbOuTwFGGA6OnEK+S238A1/VdTHPCwjVy53fwPwl/BRSGxusFUL5C3N0QSiCeX6WILQLWdDiDkVYFD8AV0ez7ipE7qbbHKlpmTxla3RBkg+YTtJShFCqlDCuoEHrDOWJWMRMSezoRtb2gUj7xFAiogTNrRm2x/06nCKmltoQ/8KGJBaWVW0ERIGB2GcSkOjIfl0AtsQtZf3e3nFCA/vbpiw06w+cgtNjNqbJZdIxkhMvHWtB5pziOpSCyL6kvPoWXfwAGyMV21ON+dyMDdTTvVmzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8CMYHj05OzMRTepSAfD/UHnESFHX4LOSDsO+WgaFUg=;
 b=CSC1zWFix5owiCNfZYE/U0/R9l0u6LBZoMWlyuiASIjukO31v/aLzZ68moYgSZHYrqAJn5oIW1b2gw/GA1L0G/BIXJGlMHOSO5gdtIurHMImSFAzD0uGYr2paG6whsri1vu2DgpccdsZMQGHvoR5oxsMe18MKv1sLyTeVfQW+aASbVZLzsSr74sB55N3VD/oeNT9vRdMGWRNHBUsgTreUMOxdbf+Gu6QQ+HmU5EGFjLrzqrNpTeSBGj/umqzEZ0WuE5bGvBc16iELABskw6v23BXNdejsa7ecGeut3GRNth1xt0x958bhddLQY1ziKhOSiuK1GdTNOdL729jMoM7yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM5PR11MB1258.namprd11.prod.outlook.com (2603:10b6:3:14::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Thu, 17 Mar
 2022 08:36:21 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::d9ee:5bb8:1828:222d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::d9ee:5bb8:1828:222d%7]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 08:36:21 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v6 6/6] Documentation: fpga: dfl: add description of OFS
Thread-Topic: [PATCH v6 6/6] Documentation: fpga: dfl: add description of OFS
Thread-Index: AQHYOQUjzk21EyQOPEqBNWzwea0TrazDPyyQ
Date:   Thu, 17 Mar 2022 08:36:21 +0000
Message-ID: <DM6PR11MB381974F8F1D288871C1FB5A285129@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220316070814.1916017-1-tianfei.zhang@intel.com>
 <20220316070814.1916017-7-tianfei.zhang@intel.com>
In-Reply-To: <20220316070814.1916017-7-tianfei.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9583599-761d-42b7-2152-08da07f13701
x-ms-traffictypediagnostic: DM5PR11MB1258:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR11MB125878452ACDCC3A6E8929CA85129@DM5PR11MB1258.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uURVer1yTWPgR+FizgnACKrf59kGRGzBp60b6/2b7XaG5tN2fM6eFj4UtxDIMiMRpQjhJQqLrYnQJQxIU3py57oSA3QHmxH8Yv0OczTZIkVX2IqAWOHNkfLrB0Uf6Wty8viiLw+85wu8btMRoI/V+GbZB85hFxBXbpQ9fRcOeUKXDDWZFw8S2E7LplgcoGVl98Vk2uM4mhhCbppQZZvVMFua55kVCdQv+ByNsbVa7n3gqy6a/Ev0/RRTRX/AICmHlIcf3mg65K5fe+ERP8tqIXCyizHMoIsk17wznALuEkgC63SaHgygN3UsKtQ4av9obnTV7Y2TY2vdW+wOd3cpWDxDF5yq4p1aDAU0pZYJvGc7sCOMkwSI1jTUNgnBvjEA+NLgpTJWznDK3rKxZajAuyUXajCmuZpO4Tcj8gug6FtQ/zzFg9xpo2j3eQJO1u5wkqL7GXqTs359jUWMqlRe6HhIkV5ac5PJ5ReLc76YlMzcfT2dNCMahV9Y4dB1SjhFL2QfJbKDMtslNUCri9lQVDwTi0AQljWcdTuyTR0fiqRKl82Ihg1mDcrOvjM9+OIH6ur/TicvE0qw+oEDKOkUX0+C5Z67LGzr5bvfCQ51MWOGFIltPM06Z9jKYgXj6Nz2NArVo8yraazVWBnjKadOA3Ix89jI3YIdeeqkkU3JOVWCxeZzhVMhfk13WBNyrw33sItHj41N1NpzqtU/iTtuh/8wyyQC79j3KmuX8stD/lI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(82960400001)(38100700002)(921005)(122000001)(9686003)(7696005)(83380400001)(6506007)(186003)(86362001)(26005)(71200400001)(2906002)(508600001)(55016003)(4326008)(66946007)(52536014)(66556008)(66476007)(66446008)(64756008)(5660300002)(316002)(76116006)(38070700005)(8936002)(33656002)(8676002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W39WVgmhcfkhYZZ3vGUNEALwADln8nlnbJl+zgvIJBV9kORyqeeCZ+y/6tol?=
 =?us-ascii?Q?WZESRMvAeHzJlhapfofvlhHA86FkDvwxP3CApujZlsx4q513by8faBCYTCfZ?=
 =?us-ascii?Q?1wWMvu+K79rnhGvLNP7pb37wZCrmYLRVsnXALAtjE645A0XVnteoo4jE2vwG?=
 =?us-ascii?Q?KerVJ7N04Ab/YMB2Ek50IHy7qyah6s9xQrvqoCb4ZFYdyrt9l8EJ7Bnu7big?=
 =?us-ascii?Q?wdz1cwrdRdqGsX/6khsHydn2TM3/LqzuX5YQCfFGy2MrSqwyAFoqCtVZ2IU6?=
 =?us-ascii?Q?pO+87678Fzq92V0NvBfutGgG9AXEh073hAI23O2djCQFI2QtlCsJ9iYvnKmT?=
 =?us-ascii?Q?Bw/xvubrvbdVm3YatAp9i6g2fcKB8g3Br9C849uyw1dZPbEv7KuZiW2PUmtj?=
 =?us-ascii?Q?L6T0pkjU3Cd4QZiSJ/vI3UP7lm3e4t7llGmFOPGH2kblyaBkuhfMkhkf2PYO?=
 =?us-ascii?Q?Kzzd/75gsCPxcspg1dlgeRiO12KEc/LgTbPVBjesvMbHlxwzUaVLmfEfT87P?=
 =?us-ascii?Q?Whh4X1+jcaZd7g/DCAm5E22a8tFWjo44zeFE7hs+WaTu4A7yfBnjVk/h6uMs?=
 =?us-ascii?Q?ohyU3AuzVBontb+FZfKsfcd/pmj7TzROfV5dySerMPIWmwKMCRE/ypDx6/Op?=
 =?us-ascii?Q?BOCPZX57AhHgX/rrL7i72hxKhghlk4LweTa9IQl1nDcpzV+kr4Ta8c4zSXJv?=
 =?us-ascii?Q?TI9phXyquxmRV7pzB6RQ5+kvtqejaSKB2/x2BEAvFhAirBgwDK4cTZympNCA?=
 =?us-ascii?Q?iXvP8GFYE6vncflB/DIIMCLupj2eqCKERswh1XUOQo5NIe0kHgssg842E3Ki?=
 =?us-ascii?Q?FNJJgBgxM+JIVCA5/OBFuCOEqDl9yzGygONYUa05dy7g4AuPM7QKKhuggQnW?=
 =?us-ascii?Q?lMxcr113wqv5zmX1JvDfMdoqQMbB9fMGencQUFHPQZoanGzci2w6/jNe5h66?=
 =?us-ascii?Q?x1BSMl/kP+YfyIohBXhP+Tz3s2E4XIR0kKk0nDgilrEwKet46eTcOuETBRnc?=
 =?us-ascii?Q?WlEDaIsk+vdTJI6U/DDIjhOhIZLG1fZHz8QMhi19DjPNBfhaYMvfe2PnPflq?=
 =?us-ascii?Q?y2abGbvld97YIZpMQ02hYY1CeS+eDUSSHmK/4RejVbGHRNBcvnKfB7CrguRQ?=
 =?us-ascii?Q?b+/vWKUpas27yXfmSDy1evU3RzL/0aTggMYbRH9Eqid88XjMyeiGlIjPpLJX?=
 =?us-ascii?Q?slzTYobRz58SZCwaqhHrbLmjcvPk2buAQ6A9FLBwd40Zl0aJ63eWLoIBbLtG?=
 =?us-ascii?Q?dAzKTwK9kuuL3uZw0bWIr9FQD4uiSC41iWaztmzpqFsLcsaT2yic1mZ2DLS/?=
 =?us-ascii?Q?aIbg4ABOMR5x4/C0Np0NPLcEtXI9hKKkQs0xN4rj6zbVKZRZhRJ141LLvXzj?=
 =?us-ascii?Q?KyVRgqE890/pK+RTbnJ9r38zRBNNOuG67esLtv9+1bpv80DUiN/2JReMPX9+?=
 =?us-ascii?Q?Tx8JUKcMENQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9583599-761d-42b7-2152-08da07f13701
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 08:36:21.6117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hfWhFbtn+JfdNQtpCgFiDhlxWblNYp/reLYl0bP+LFDbul7DDK/7JEZJpcklkcth/KkDQFY5KHSqsUQMEqbvPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1258
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v6 6/6] Documentation: fpga: dfl: add description of OFS
>=20
> From: Tianfei zhang <tianfei.zhang@intel.com>
>=20
> This patch adds description about OFS support for DFL.

I think another major extension is for SRIOV support, DFL needs to be exten=
ded to support
another SRIOV usage model, could we have some more descriptions for that?
e.g. In the new usage model, that PORT is not turned into VF and still can =
be accessed
in PF? how port release will be handled (or ignored) in this new model?=20

>=20
> ---
> v6:
> fix documentation with Randy's comment.
> v5:
> fix documentation with Matthew and Randy's comment.
> v4:
> add description about access the AFU on "multiple VFs per PR slot" model.
> v3:
> change IOFS to OFS in documentation.
> v2:
> * Fixs some typos.
> * Adds more detail description about the models of AFU access which suppo=
rted
> in OFS.
>=20
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> ---
>  Documentation/fpga/dfl.rst | 114 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 114 insertions(+)
>=20
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index ef9eec71f6f3..93f262fe7b8c 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -556,6 +556,120 @@ new DFL feature via UIO direct access, its feature =
id
> should be added to the
>  driver's id_table.
>=20
>=20
> +Open FPGA Stack
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Open FPGA Stack (OFS) is a collection of RTL and open source software
> providing
> +interfaces to access the instantiated RTL easily in an FPGA. OFS leverag=
es the
> +DFL for the implementation of the FPGA RTL design.
> +
> +OFS designs allow for the arrangement of software interfaces across mult=
iple
> +PCIe endpoints. Some of these interfaces may be PFs defined in the stati=
c
> region
> +that connect to interfaces in an IP that is loaded via Partial Reconfigu=
ration
> (PR).
> +And some of these interfaces may be VFs defined in the PR region that ca=
n be
> +reconfigured by the end-user. Furthermore, these PFs/VFs may use DFLs su=
ch
> that
> +features may be discovered and accessed in user space (with the aid of a
> generic
> +kernel driver like vfio-pci). The diagram below depicts an example desig=
n with
> two
> +PFs and two VFs. In this example, it will export the management function=
s via
> PF0,
> +PF1 will bind with virtio-net driver presenting itself as a network inte=
rface to
> +the OS. The other functions, VF0 and VF1, leverage VFIO to export the MM=
IO
> space
> +to an application or assign to a VM.
> +::
> +
> +     +-----------------+  +--------------+  +-------------+  +----------=
--+
> +     | FPGA Management |  |   VirtIO     |  |  User App   |  | Virtual  =
  |
> +     |      App        |  |     App      |  |             |  | Machine  =
  |
> +     +--------+--------+  +------+-------+  +------+------+  +-----+----=
--+
> +              |                  |                 |               |
> +     +--------+--------+  +------+-------+  +------+------+        |
> +     |     DFL Driver  |  |VirtIO driver |  |    VFIO     |        |
> +     +--------+--------+  +------+-------+  +------+------+        |
> +              |                  |                 |               |
> +              |                  |                 |               |
> +     +--------+--------+  +------+-------+  +------+------+   +----+----=
--+
> +     |     PF0         |  |     PF1      |  |   PF0_VF0   |   |  PF0_VF1=
  |
> +     +-----------------+  +--------------+  +-------------+   +---------=
--+
> +
> +As accelerators are specialized hardware, they are typically limited in =
the
> +number installed in a given system. Many use cases require them to be sh=
ared
> +across multiple software contexts or threads of software execution, eith=
er
> +through partitioning of individual dedicated resources, or virtualizatio=
n of
> +shared resources. OFS provides several models to share the AFU resources=
 via
> +PR mechanism and hardware-based virtualization schemes.
> +
> +1. Legacy model.
> +   With legacy model FPGA cards like Intel PAC N3000 or N5000, there is
> +   a notion that the boundary between the AFU and the shell is also the =
unit of
> +   PR for those FPGA platforms. This model is only able to handle a
> +   single context, because it only has one PR engine, and one PR region =
which
> +   has an associated Port device.
> +2. Multiple VFs per PR slot.
> +   In this model, available AFU resources may allow instantiation of man=
y VFs
> +   which have a dedicated PCIe function with their own dedicated MMIO sp=
ace,
> or
> +   partition a region of MMIO space on a single PCIe function. Intel PAC=
 N6000
> +   card has implemented this model.
> +   In this model, the AFU/PR slot was not connected to port device. For =
DFL's
> view,
> +   the Next_AFU pointer in FIU feature header of port device points to N=
ULL in
> this
> +   model, so in AFU driver perspective, there is no AFU MMIO region mana=
ged
> by
> +   AFU driver. On the other hand, each VF can start with an AFU feature =
header
> without
> +   being connected to a FIU Port feature header.
> +
> +In multiple VFs per PR slot model, the port device can still be accessed=
 using
> +ioctls API which expose /dev/dfl-port.h device nodes, like port reset, g=
et
> +port info, whose APIs were mentioned in AFU section in this documentatio=
n.
> But
> +it cannot access the AFU MMIO space via AFU ioctl APIs like
> DFL_FPGA_PORT_DMA_MAP
> +because there is no AFU MMIO space managed in the AFU driver. Users can
> access
> +the AFU resource by creating VF devices via PCIe SRIOV interface, and th=
en
> access
> +the VF via VFIO driver or assign the VF to VM.
> +
> +In multiple VFs per PR slot model, the steps to enable VFs are compatibl=
e with
> +legacy mode which are mentioned in "FPGA virtualization - PCIe SRIOV" se=
ction
> +in this documentation.
> +
> +OFS provides the diversity for accessing the AFU resource to RTL develop=
er.
> +An IP designer may choose to add more than one PF for interfacing with I=
P
> +on the FPGA and choose different model to access the AFU resource.
> +
> +There is one reference architecture design using the "Multiple VFs per P=
R slot"
> +model for OFS as illustrated below. In this reference design, it exports=
 the
> +FPGA management functions via PF0. PF1 will bind with virtio-net driver
> +presenting itself as a network interface to the OS. PF2 will bind to the
> +vfio-pci driver allowing the user space software to discover and interfa=
ce
> +with the specific workload like diagnostic test. To access the AFU resou=
rce,
> +it uses SR-IOV to partition workload interfaces across various VFs.
> +::
> +
> +                              +----------------------+
> +                              |   PF/VF mux/demux    |
> +                              +--+--+-----+------+-+-+
> +                                 |  |     |      | |
> +        +------------------------+  |     |      | |
> +  PF0   |                 +---------+   +-+      | |
> +    +---+---+             |         +---+----+   | |
> +    |  DFH  |             |         |   DFH  |   | |
> +    +-------+       +-----+----+    +--------+   | |
> +    |  FME  |       |  VirtIO  |    |  Test  |   | |
> +    +---+---+       +----------+    +--------+   | |
> +        |                PF1            PF2      | |
> +        |                                        | |
> +        |                             +----------+ |
> +        |                             |           ++
> +        |                             |           |
> +        |                             | PF0_VF0   | PF0_VF1
> +        |           +-----------------+-----------+------------+
> +        |           |           +-----+-----------+--------+   |
> +        |           |           |     |           |        |   |
> +        |           | +------+  |  +--+ -+     +--+---+    |   |
> +        |           | | Port |  |  | DFH |     |  DFH |    |   |
> +        +-----------+ +------+  |  +-----+     +------+    |   |
> +                    |           |  | DEV |     |  DEV |    |   |
> +                    |           |  +-----+     +------+    |   |
> +                    |           |            PR Slot       |   |
> +                    |           +--------------------------+   |
> +                    | Port Gasket                              |
> +                    +------------------------------------------+
> +
> +
>  Open discussion
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial
> reconfiguration
> --
> 2.26.2

