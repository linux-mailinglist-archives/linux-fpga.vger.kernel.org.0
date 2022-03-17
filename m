Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89B74DC24A
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Mar 2022 10:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiCQJEG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Mar 2022 05:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiCQJEG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 17 Mar 2022 05:04:06 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7511D08E3;
        Thu, 17 Mar 2022 02:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647507770; x=1679043770;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/bZxxn5/THumFCyVi9lS61cYK+MpT+qzvXQgbZOHzao=;
  b=fj0gaIIgoe9sIhbNIUHqFm576XSRcGo5fbyr+MrwHSSWvvZAxX06LEHI
   o+18IL2OxK8uDzkm4gLlQc2x4s3M1H0Xb2bzf/83QTPHIQbLwgDnHO7Mq
   ldfd6uf7mUgRgnzlO+YwsfBMASD0cFzkQIIRhcBNRVNa7tfOhZa8FFwkG
   8zY8LEeLBINF//jZgQiF4UPLbjDyIfj4526T20ZNWHiVMZ0TzC6OEQ6X/
   T0iq2GbzMcnWz2jnelcH5wi+qyEMbs4EukvQeldpePSQ+D0KYXEGSXi+z
   kCaGqDK1Nlpkor7OpfmQCqWdxQdaSaKhcn+UZJE4bLy9EMkiT4B9TSar/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="317538845"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="317538845"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 02:02:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="821332346"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga005.fm.intel.com with ESMTP; 17 Mar 2022 02:02:30 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 02:02:30 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 02:02:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 17 Mar 2022 02:02:29 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 17 Mar 2022 02:02:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRKHqoMqSfYN8LyDOCdnVbd4VbdOseMIeQbKziu/5Igyz0CgqJWJmzumyq+BuUYm36aTQXtNEo75cB4LMbRH96I6b7xp5EkmBdVf0NZxr6pBM3UKKatb9fI29V2dfGl27crSrs3qpiGj/pwzcyhwHrhsQV3JRGbhIsmdy4h7fNIAbPJtjL51Dt40o/JecLX1U5FWxVPNYE9t5G9FHA/XfLMCjqlCkVa/ONS9/8dBmb/bTd6bMM7TKyuNfiYXjmpmsPc4MCrQFMOFBOFubNECuQ7NcCZ2HBkpp7/dcgEDIFBuUMx0fqefXl9lPyZOkNJfRYDgBnSPWgGk/5n7Uc5bHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkZ/YswT5Pk6y823C5kD5rTlgLkF6k1ODSca70/zk8Y=;
 b=Du9eGftXAiWfy9MbI6+XV3Qi5O5QN1uWu2Yp0A3ZUnKrBo4Lg7liiTxl3A8h+XzGajLA5MYn7fmsFo/Zrfh9OP1NoRtew7jHejPpTS8aVbOaYHHD0qdDNE+/nDop70xHK0QfI5d5FCabkIDCeNU6oajduWONPnl8yZY1kq44fTkwjB9D6CVnTCBY24eih9N1hfAlFssavTxX5dxFCo6Z5bc5Ekf9TQcIvFhNAjgF+8VYQrOLedxnTiwGCPboBqEYzRfm5PrCIs9m16fZQGgcgSJxCoqk/YF9lwAMD9NNSRzPQd/yDnPlYlDj97TfwcTen4+jB+iy3Rb2/035znp7Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by CY4PR11MB1752.namprd11.prod.outlook.com (2603:10b6:903:11a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 09:02:26 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809%5]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 09:02:26 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v6 3/6] fpga: dfl: check released_port_num and num_vfs for
 legacy model
Thread-Topic: [PATCH v6 3/6] fpga: dfl: check released_port_num and num_vfs
 for legacy model
Thread-Index: AQHYOQUgpEmUfpl9g0qT9gnpkkgemKzDRbkAgAAC7eA=
Date:   Thu, 17 Mar 2022 09:02:26 +0000
Message-ID: <BN9PR11MB5483011FA979497ECE41915FE3129@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220316070814.1916017-1-tianfei.zhang@intel.com>
 <20220316070814.1916017-4-tianfei.zhang@intel.com>
 <DM6PR11MB381950AC46C7913128AE212D85129@DM6PR11MB3819.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB381950AC46C7913128AE212D85129@DM6PR11MB3819.namprd11.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.401.20
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8284b74a-9eb4-4f59-357f-08da07f4dbae
x-ms-traffictypediagnostic: CY4PR11MB1752:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CY4PR11MB1752A1D40C6DC45B2A15DD57E3129@CY4PR11MB1752.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DrkvrDTQJ3mR51PYcxG76x1KtNFuce76ZyA2No9jd8KHiODvT183TSELHphaj/ewwPLsKiHG1SUOPmRGFmiE4BJNEBbGS+L0lb/lrC1pcydqGOxNvEmAB23O1D+nX8QviSE9cgYmgtEU4H3xyPIK11T23277Hp5C1gUkhwyxbBAmM+7IQgU3jHFpkrATo+/BN9+zV5U7LGKk7khnJUfWc5i6ROjl5eUaA38Wdy1Ogn4/t7AbE+sTQ3Rig7gec6BfSdStFVug6K+CkUdZg1IiXocK2/Wtqpq9KCM2nnXITgNWJ0JxPKG432Dg57Q7GIfRXqLAYIyIN4NfCrmTnXny6GoR1DBHEfOe1mGkLUX/JN/JuVc7wx/WwFouaFxG1qlC43/pGNFX4rBs6YzVu9bxGYNjABOLuCtiX04sFT2K0j0YVVk0HY+z6VNiecmUysdMK9SxkzHdeovy/V8B4lO7CEE+qGRp9ai2tpFqyK0QIckfBMmH+b8wzFKB5UWjDXPkTYBaBPkB+sr2Pa6FxqZDWwdipKzgHUV4y4RAx26Qtp9o/9Srwn9VhbsEX31YGONjmY8xhqK5xoUGRz5YZlpLvP45uZkJa+2Qrm9qWjIDD6hv5iDBTo5uhlpMPWpsPLymEs3ArUnxG6iPNHnYfdXytNbfziEpg5CJ+32KzB7W4xBzI69G09ch9OfBpSKs6yPLTUliLL5wq4iYJjYm4SVT14oqyXSwH2wdtl2wEZj4FCU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(82960400001)(66476007)(6506007)(66446008)(8936002)(110136005)(7696005)(26005)(186003)(55016003)(122000001)(33656002)(921005)(52536014)(71200400001)(38070700005)(4326008)(66556008)(9686003)(38100700002)(5660300002)(86362001)(8676002)(53546011)(316002)(2906002)(508600001)(83380400001)(64756008)(76116006)(66946007)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vcEsGc1F/76Ymk0yy7/Ia3Y7j0KypAzYkWZgteKbxMiMdWszz7O1Vyub5D21?=
 =?us-ascii?Q?nhyObENbETJ0jTLSyZk0hkbAuuAG0M7Y3sKCxu+Ccsb9qRyNksWiKv6sKeX0?=
 =?us-ascii?Q?fPwk29IZ3EiTcSDA4WiAh9NfGu7m7wrSOoCXeY9J6x8fcMmiMAxHsDupJbQq?=
 =?us-ascii?Q?5/kHK6P4HFR99wuCccrENs5ndvKWAZ5yAUeC2LvTLNyQoE3YIaDMxtfrW6Cx?=
 =?us-ascii?Q?GtjSI31PAxxQOK9P6SYJUxWVL6gK07TadglSL3X2cwA8QaW4Ie3NWJMuQFyN?=
 =?us-ascii?Q?O+J2o9F8TjryAafRL8p4h6d5ApaeVU9bOqhJAWAO+OZmIaW3MD2zfDNYlbut?=
 =?us-ascii?Q?Btx+HujNToJTDQEqBxJaZS9soVHeYw+sKftRh6mJ1o5koSAVBO/m8vQYIsZE?=
 =?us-ascii?Q?VHU2imczHO3EfjhE+HVzhcpgR06xXZBaYOv9FHEU+sWaPBnLiQZFNThb0frt?=
 =?us-ascii?Q?kI10Q+IvujRQvcu/zBDOit/EqiASkZMEUvZ2pNvZMnlFr6Qaba4AwmGdpbvz?=
 =?us-ascii?Q?IPmgykMhKC0Ex5Yfi1j9z2nn7LfTDLDlxc3ASMjL/lwea7D0bLEEet/x9CFI?=
 =?us-ascii?Q?LvAxEOr3+Jv0PlRnmZm1Pdzap8R8guR7WCQVNxVroRSqcVFaGC3nvX6cYOqJ?=
 =?us-ascii?Q?/Vmaoj4DeolMw9/iZ8q6B58gGHRKCTfbMMPbdb+wPgAf7v+l1IeC2dki7CcG?=
 =?us-ascii?Q?/CIKx6SG6qH5jhlNam8rRAgJzdETgUrB26SHY6JPL4BAwI2JIaFAP7O34K/l?=
 =?us-ascii?Q?flsB1RSKZXByPsVCHOJdJcqdEv2EkXlfoPOXYnRAOvQ12yAoZB/oJyVo+eeK?=
 =?us-ascii?Q?O4zqht5DB+lEk1RNOwH1HjVhEA02xOZ7G8I3KEBEI9doRWrLzhe5CnJU6wor?=
 =?us-ascii?Q?BXiW2iZ13dYODcA9/AUdZTt+dCuLZrl2I836ajA7mSzQAE3kEueDdQFKfwC1?=
 =?us-ascii?Q?rYFf0cSrLtaJss/bl304FLrNeLbQxlI83cpLgHHaABouNvmfUHpjW5KEZ5st?=
 =?us-ascii?Q?Le769BQtbw7jnMiX6TgkO7Ub4Sy49e6H3gVvCQDwA6hMsEBDmfOI8YkXHfpx?=
 =?us-ascii?Q?jJoyzlYLhynHX/pAwLa1k1RDZdzkV6jiVlhBACsrvZR9zfwhKasguxMhkeIB?=
 =?us-ascii?Q?6EjAMvtoSx9YV13I3wSBiyUESlbGDjyxWcJZjdfr7B4FRUH16+qUa3ASh8y5?=
 =?us-ascii?Q?ONfv+gxGKAaFtKFZX9zev9h97ZJGbvGH61dfMTJnqvZUR7offV7LF0+wXrJI?=
 =?us-ascii?Q?RayHasXyEDCHKrSaFbF93dsSQczWwnjgQOPWclEeQ3QoxOTqJKToA/RjqNK/?=
 =?us-ascii?Q?c70J2dBBxX+NCObtA3zW3rterBvXtnG5djOMB8ht1FjXa3UU73LwcpDHf32r?=
 =?us-ascii?Q?ymsiWzdW/lNSkUZh/9J6KzLUhT08Y0Uj3mownqqPe5sv1cTpRBJ5u7nl6o9H?=
 =?us-ascii?Q?GEKnIZ0bJwCkwSWct0D4GW53Tgd0IzmL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8284b74a-9eb4-4f59-357f-08da07f4dbae
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 09:02:26.4763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FxE7onwp9cBp5Hho68ySx/knb65t3My8Myevx5ZQyoxrdt3tdm1AVUbudiqU0zjJiJaxF/zFA8yQAW/0aRQjaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1752
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



> -----Original Message-----
> From: Wu, Hao <hao.wu@intel.com>
> Sent: Thursday, March 17, 2022 4:49 PM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>; trix@redhat.com;
> mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.or=
g;
> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> rdunlap@infradead.org
> Cc: corbet@lwn.net; Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Subject: RE: [PATCH v6 3/6] fpga: dfl: check released_port_num and num_vf=
s for
> legacy model
>=20
> > Subject: [PATCH v6 3/6] fpga: dfl: check released_port_num and num_vfs
> > for legacy model
> >
> > From: Tianfei zhang <tianfei.zhang@intel.com>
> >
> > In OFS legacy model, there is 1:1 mapping for Port device and VF, so
> > it need to check the number of released port match the number of VFs
> > or not. But in "Multiple VFs per PR slot" model, there is 1:N mapping
> > for the Port device and VFs.
>=20
> The title and commit message seems not matching the code..
> From code it sounds like we are trying to skip the PORT (PF access-> VF a=
ccess)
> function, as new SRIOV usage model is introduced.
> Probably we can skip it early in this function or even skip this function=
 directly. It
> doesn't matter it's 1:N or 1:1, we always want to keep PF access to port,=
 right?

For 1:1, there is 1 port mapping the 1 VFs, and we check the num_vfs was eq=
ual  with released ports or not.
But for 1:N, it break this checking.

>=20
> >
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> > ---
> >  drivers/fpga/dfl.c | 10 ++++++----
> >  drivers/fpga/dfl.h |  2 ++
> >  2 files changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c index
> > 712c53363fda..b95b29c5c81d 100644
> > --- a/drivers/fpga/dfl.c
> > +++ b/drivers/fpga/dfl.c
> > @@ -1707,11 +1707,13 @@ int dfl_fpga_cdev_config_ports_vf(struct
> > dfl_fpga_cdev *cdev, int num_vfs)
> >
> >  	mutex_lock(&cdev->lock);
> >  	/*
> > -	 * can't turn multiple ports into 1 VF device, only 1 port for 1 VF
> > -	 * device, so if released port number doesn't match VF device number,
> > -	 * then reject the request with -EINVAL error code.
> > +	 * In the OFS legacy model, it can't turn multiple ports into 1 VF
> > +	 * device, because only 1 port conneced to 1 VF device, so if release=
d
> > +	 * port number doesn't match VF device number, then reject the reques=
t
> > +	 * with -EINVAL error code.
> >  	 */
> > -	if (cdev->released_port_num !=3D num_vfs) {
> > +	if ((dfl_has_port_connected_afu(cdev) &&
>=20
> Could we really use this as indication for which SRIOV model of hardware?
>=20
> > +	     cdev->released_port_num !=3D num_vfs)) {
> >  		ret =3D -EINVAL;
> >  		goto done;
> >  	}
> > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h index
> > bc56b7e8c01b..83c2c50975e5 100644
> > --- a/drivers/fpga/dfl.h
> > +++ b/drivers/fpga/dfl.h
> > @@ -471,6 +471,8 @@ void dfl_fpga_enum_info_free(struct
> > dfl_fpga_enum_info *info);  #define DFL_PORT_CONNECT_BITS
> > MAX_DFL_FPGA_PORT_NUM  #define DFL_FEAT_PORT_CONNECT_MASK
> ((1UL <<
> > (DFL_PORT_CONNECT_BITS)) - 1)
> >
> > +#define dfl_has_port_connected_afu(cdev) ((cdev)->flags &
> > DFL_FEAT_PORT_CONNECT_MASK)
> > +
> >  /**
> >   * struct dfl_fpga_cdev - container device of DFL based FPGA
> >   *
> > --
> > 2.26.2

