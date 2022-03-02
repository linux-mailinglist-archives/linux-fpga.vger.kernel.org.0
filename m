Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89D94C9B53
	for <lists+linux-fpga@lfdr.de>; Wed,  2 Mar 2022 03:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbiCBCnq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 1 Mar 2022 21:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbiCBCnp (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 1 Mar 2022 21:43:45 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF273D1DA;
        Tue,  1 Mar 2022 18:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646188983; x=1677724983;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8I7zxA3AN64v0Xt9mbsOpQ7M3/n2iLskvHWA2z1pf9U=;
  b=PC0CAqw6yqSgQJACEFGjzp8qRiy8XOdeyqwLQ0CcbQDu/OzL5hl+bOgS
   G39TxAWuSSL4B3yC3yHZ4KB36QQa6LbzXVLlqkpGzE+zWyq+BhVnixnPb
   WGG9Xoa+tCQYDd97KgdEDlVA6ETwhCEKEdUHZQRr7zc8jBh27yuXFoNfy
   sX/tTStATzl5rhdnz/+ELAOpRRlXKGjTosiTqb0qGxYd0G7HlZgxm2XwZ
   QGyxH3o+vvoWfzyqpP01CPJpFsVGoLKJUOql5S4BWY1yrWHDLE3MhUGo/
   RtgaTQ3qEqhZdwcoEf+tnf+fVoI2s02b0Tdsl0gN0KUi7/NExFy2dgetS
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="250871094"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="250871094"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 18:43:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="508041336"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga002.jf.intel.com with ESMTP; 01 Mar 2022 18:43:02 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 18:43:01 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 18:43:01 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 1 Mar 2022 18:43:01 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 1 Mar 2022 18:43:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cub9fMAInwUKo/1Yuz6mufKjUcyLYN7iJdViQIu00e6N0stoQsSZPzx8SZJNBBiWzY1fNY9OEcUThRSjxYxYIjF2yIOAfMrPYW2YM07e8vdYFZ78QcG2ABV9VeqBCGc+eDxfiNqoTfRvmPbTId3KwUSkUcVttGXvC2+6QbyLtA5CVlFumBio5o8gEcMLV8CG6BSUDTAUkviYr6kq+p3u3q+QaYGJEFaU1dJ1f0L1AL7Kr1kfcgdGTuSnswaoN9WjsakgtXQYM+2g0B2b3wp64RBcejmZ+B8JjhlVPHPvD4xDN9fUkLrPsiWgY/JVDIQVfeuDfxSSc3ILd0dBO6quKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpXiRtcGcvNjk6FKJPS+PE7fdU9/H2VoqVJE0RtHBBY=;
 b=mEbSwG/ejXiaRw9QuzC2+u3ftAvCBRc4iwP1F86vSCjU8CTdxc1peuvLkECD8JmgSAjysJnCt3jJd0Meb3GUouP3S9qcjmUmiyP1ERw4R2Ah5RF971BLUHULi6qOPTd7fp7S7Nhneilu9vSlW/wK3wwFt9moDqFTyJ2FWtjCYuMOkkS55D2Vtjw7simCHXJqkk/IavTxXJiAW9Ey86S/I2Pg0xU/Mgvw0eUrTdprh0MDCpPfS7pzFxpsBzM1M/OVSnBv0QVZAc6Ok//8k56bPn1p7cmpLGVHiQYqJUXMlqIUJxAm3Zp23xED5BSYm2HT7WeJAhqDRG8FtMtCQRthcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by DM5PR11MB1803.namprd11.prod.outlook.com (2603:10b6:3:10f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 2 Mar
 2022 02:42:58 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809%6]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 02:42:58 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v3 4/5] fpga: dfl: Handle dfl's starting with AFU
Thread-Topic: [PATCH v3 4/5] fpga: dfl: Handle dfl's starting with AFU
Thread-Index: AQHYLTUS/WqmQ7pqK06QW0h5Eg8NIKyqITsAgAFB1eA=
Date:   Wed, 2 Mar 2022 02:42:57 +0000
Message-ID: <BN9PR11MB5483A47492DF649120661176E3039@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220301062123.818687-1-tianfei.zhang@intel.com>
 <20220301062123.818687-5-tianfei.zhang@intel.com>
 <DM6PR11MB3819951873CB00D510AB0B7685029@DM6PR11MB3819.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB3819951873CB00D510AB0B7685029@DM6PR11MB3819.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: adb43433-b7d3-4b4c-e06a-08d9fbf65c7c
x-ms-traffictypediagnostic: DM5PR11MB1803:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR11MB180395EC78DF48E315896C94E3039@DM5PR11MB1803.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nTwMiYLJ2Z09ELEnrrcjTSArpUZnpmqetcRCJA09gmYpLG6xS7A57ZBWAtOSKyyLEdvMSK7UovG7m7cCebcUzvam/URDinmYC1swLcsn1ZHvUq15IfRjFdRGzRHAcEdvP+Rh9z3la1/XX5i0vvEc2tYNWgnFlmC7N3H1ZWvaXfn2pQJEAp8MGmG09u3n9rVRfATgI+zTcy58QYH4S6YRnbNqdcYM6ZZhR7kaWms1YcfquQ8EPazV4jM751dJ3cq+8LBOe5Z1VZrJF8oaMwMmFQs3Dpa2gpNUTNnhKGNrX47mK5f4sVerJGo8f8+MvYIwTldjNniZuEDqmsoXQeOgIQjzqXdyq7GMTrxg0Eq5M1uvcEyvoGaUsYhdkJCrp1WugkJ/m+mQzoQwHX126DyCb6XV+2AXvypN0/W11ZPY4C4rDR5ShHxLY0vQSNPPP7NQTd4OhQcIWCendsv7ASQV83687B1JTU3H303PbFgRYObjtkNPH8PIXw3eN++a5KJDBpUizUxvZ7zkh4OFIBor1x0p/0zKodkIXePA9JH4rFoQttPpv/xYId6HUWSYzv0a3R+R1MFFfRNgtRGXz1RlQ2kHk/QaIQATNSYk6T6zjc51Me0UvNY0pXW8068rl9/kD/EOZZS7s+Z6UQxgu83eVvSjT14ERckBkB5qJWPMO9YNacIWA+lzF12B+cSgB/ATSwrYzeBKUwaGgkK8uzOJUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(8936002)(86362001)(9686003)(33656002)(316002)(53546011)(186003)(6506007)(26005)(7696005)(54906003)(83380400001)(110136005)(66556008)(122000001)(38100700002)(4326008)(66446008)(66476007)(8676002)(64756008)(2906002)(508600001)(52536014)(82960400001)(66946007)(76116006)(5660300002)(55016003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OYIZlWd+yesz4y2LXztFqYBIVFSuJ8IqhW8ykiFAcJ4OS1JAzKVcJDCTnq+l?=
 =?us-ascii?Q?V+y7TfpYjEVJE36McA64NbuvaaIKvr24ObHZ4bXltYan7xc40cx0aVA87rC6?=
 =?us-ascii?Q?AXmJLv3+lxlxSXNXUHP+CVCIiPO3TvXcHndrGrKrcBQvxCCvog9RbIApxzQ+?=
 =?us-ascii?Q?7kLKB8sqgS1YOI5YZ658gL3hiuLkYuUGB0wvXMWwikGTbNfgxkxtaX89EaYg?=
 =?us-ascii?Q?7JGKRIlbWM52hXnqD/F2T94y3EdhpMHXVj8KMytgTzQ6f4VdSDKGDw4IQi2h?=
 =?us-ascii?Q?zl/mMpqbYpeJkG8wLIfvoHcn59d/uVe497Wsvo5fHmu5STxfh+bO+Tq4Qc7+?=
 =?us-ascii?Q?HgkhLEDqvX7dL/PNF+PYC71f5bzupZwpN+zxe1cQga1C87K41yb64OD/zaOt?=
 =?us-ascii?Q?P8KFZQS9GhyGw7rcz+oUVPlMCr98lOgwOAkFJAOWKjFVjgRxg+hyTZB13nJ5?=
 =?us-ascii?Q?0mZt8UL8/tiSoqU0YhN0PLeuHJHPEVnVCW8hP97eM0/8km+Mhk7q5YRynshQ?=
 =?us-ascii?Q?XDcYK5J3/tbgW90XdP7RfUxYw/CCARv86qlLBTSCHKjwzTnSXioJhf/8z7fs?=
 =?us-ascii?Q?AiAn1FGoim5zdwWI9F7z8snrXV6aZ9pY30b8zvbOMCnPvYJOKbiQmXfq+uEQ?=
 =?us-ascii?Q?0J6nrADN99o02aKYp+u2ovKeBo/7YxSEhPMWWqs+Ervhxn0OedK5JTOSFQDi?=
 =?us-ascii?Q?uQufB3cELA6LgD6JlWDml5WmREyZSZ2VaTlpMzo+EKZ1ztaZART1iC3toDop?=
 =?us-ascii?Q?wQKSiV6VJ/xwVQMwmXQg3+9jKc2BdmEzgrqyJ5hOXS+onb6qeitN2WWjeOAN?=
 =?us-ascii?Q?kGzq+mq0JgV5XZGRogorAstyyodEB/mjl+82g2w/yT0IGZv5zwmnGbg1rEGC?=
 =?us-ascii?Q?ucYAwU8LxK2ad7zfXpurfkDLFNfmCWBIRFDzeMProPsmjS132i2KtSJlUD33?=
 =?us-ascii?Q?GFYc0A5DaqiOaIxozmgjzv+VxJEtiMUSh4GjpjOY4ib1fpfDyMJurePLb00n?=
 =?us-ascii?Q?+Ms7o6s6sXp/vym4bS6HlbtE54OcaV4AYGobqYtj9peqhYThpNO1j76EWnqc?=
 =?us-ascii?Q?WqsX0Xru73XEmNTe//FW8dU9PTgCqNq4wmRG3R17Bt5r7JvgmazxTuHS7WSu?=
 =?us-ascii?Q?HaInhWybrJgQXVA+0sDUiEvSJUKCnrkGW7fxxrXpR6UVw4GIH0oPk82cZmYr?=
 =?us-ascii?Q?IyoMcTFp+CjGekazcushDw3UhbczaNcrQK9+zowOEzHvow1dArkrr8UPf8rw?=
 =?us-ascii?Q?B5rhVFdob/3ZgDYGmnmQhrZof/EGlsvzP/TbSQkU+obfPlhe5AgSfmk4E4xk?=
 =?us-ascii?Q?rBQCRrJHwAMOJf5YG49/4hUq7nt2tFdSJri/ye9RBsO+haJzz6XzAaKNDCGA?=
 =?us-ascii?Q?sZAdPNNpgdwf4l6Pcwx3wRyqR06xXpispW9JTC0phDaMzcS+u6e0gLloeHOw?=
 =?us-ascii?Q?koaZC2VDHp6FT8Dbo3seSqpx6EKbHunt0fkzC/hoPKVhwara3TjlNVn1IF3K?=
 =?us-ascii?Q?PZbHRbq+YzrgPa3tf42LtsNxu2nPoTZXJYVwygf9MYcvJTcrP2hQi/J1XLI6?=
 =?us-ascii?Q?wLcp4NvLIzapfLbRggHsL9cTopgEPCASjfLrk4va5vr88ojp7a5zGXrjBhF5?=
 =?us-ascii?Q?6Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adb43433-b7d3-4b4c-e06a-08d9fbf65c7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 02:42:58.0287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PQm3hqzZOqGcMqsI/qtVpwpHSVykIYkf2iAKhfc1qOgFWQzhs1F9m9Yh3UGRT2z4xyKkkWndSBWKlySzEUcuHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1803
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



> -----Original Message-----
> From: Wu, Hao <hao.wu@intel.com>
> Sent: Tuesday, March 1, 2022 3:28 PM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>; trix@redhat.com;
> mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.or=
g;
> linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; corbet@lwn.net; Matthew Gerlach
> <matthew.gerlach@linux.intel.com>
> Subject: RE: [PATCH v3 4/5] fpga: dfl: Handle dfl's starting with AFU
>=20
> > -----Original Message-----
> > From: Zhang, Tianfei <tianfei.zhang@intel.com>
> > Sent: Tuesday, March 1, 2022 2:21 PM
> > To: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; Xu,
> > Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.org;
> > linux-doc@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org; corbet@lwn.net; Matthew Gerlach
> > <matthew.gerlach@linux.intel.com>; Zhang, Tianfei
> > <tianfei.zhang@intel.com>
> > Subject: [PATCH v3 4/5] fpga: dfl: Handle dfl's starting with AFU
> >
> > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> >
> > Allow for a Device Feature List (DFL) to start with a Device Feature
> > Header (DFH) of type Accelerator Function Unit (AFU) by doing nothing.
> > This allows for PCIe VFs to be created.
>=20
> Why this is related to VFs creation? We don't have AFU in PF in OFS case,=
 right?

Yes, in " Multiple VFs per PR slot" model, the AFU was not connected with P=
ort.

>=20
> >
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > ---
> >  drivers/fpga/dfl-pci.c |  7 ++++++-
> >  drivers/fpga/dfl.c     | 22 +++++++++++++---------
> >  2 files changed, 19 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c index
> > 33545c999c06..e7d58e7b1bbd 100644
> > --- a/drivers/fpga/dfl-pci.c
> > +++ b/drivers/fpga/dfl-pci.c
> > @@ -275,7 +275,12 @@ static int find_dfls_by_default(struct pci_dev
> > *pcidev,
> >
> >  		dfl_fpga_enum_info_add_dfl(info, start, len);
> >  	} else {
>=20
> Can be something like else if dfl_feature_is_afu(base) following the same=
 style.

dfl_feature_is_afu(base) will be better.

>=20
> > -		ret =3D -ENODEV;
> > +		v =3D readq(base + DFH);
> > +		if (FIELD_GET(DFH_TYPE, v) !=3D DFH_TYPE_AFU) {
> > +			dev_info(&pcidev->dev, "Unknown feature type 0x%llx
> > id 0x%llx\n",
> > +				 FIELD_GET(DFH_TYPE, v), FIELD_GET(DFH_ID,
> > v));
> > +			ret =3D -ENODEV;
> > +		}
>=20
> But nothing else done for AFU so far? How it works? Sounds like more patc=
hes
> are required.

In " Multiple VFs per PR slot" model, we access the AFU resource via VFs fo=
r example VFIO-PIC driver, and we cannot access the AFU MMIO resource by AF=
U APIs.

>=20
> >  	}
> >
> >  	/* release I/O mappings for next step enumeration */ diff --git
> > a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c index
> > fd04ef5c8b03..e30bbb3039cd 100644
> > --- a/drivers/fpga/dfl.c
> > +++ b/drivers/fpga/dfl.c
> > @@ -900,9 +900,11 @@ static void build_info_free(struct
> > build_feature_devs_info *binfo)
> >  		dfl_id_free(feature_dev_id_type(binfo->feature_dev),
> >  			    binfo->feature_dev->id);
> >
> > -		list_for_each_entry_safe(finfo, p, &binfo->sub_features, node)
> > {
> > -			list_del(&finfo->node);
> > -			kfree(finfo);
> > +		if (!list_empty(&binfo->sub_features)) {
> > +			list_for_each_entry_safe(finfo, p, &binfo-
> > >sub_features, node) {
> > +				list_del(&finfo->node);
> > +				kfree(finfo);
> > +			}
> >  		}
> >  	}
> >
> > @@ -1439,12 +1441,14 @@ dfl_fpga_feature_devs_enumerate(struct
> > dfl_fpga_enum_info *info)
> >  	 * start enumeration for all feature devices based on Device Feature
> >  	 * Lists.
> >  	 */
> > -	list_for_each_entry(dfl, &info->dfls, node) {
> > -		ret =3D parse_feature_list(binfo, dfl->start, dfl->len);
> > -		if (ret) {
> > -			remove_feature_devs(cdev);
> > -			build_info_free(binfo);
> > -			goto unregister_region_exit;
> > +	if (!list_empty(&info->dfls)) {
> > +		list_for_each_entry(dfl, &info->dfls, node) {
> > +			ret =3D parse_feature_list(binfo, dfl->start, dfl->len);
> > +			if (ret) {
> > +				remove_feature_devs(cdev);
> > +				build_info_free(binfo);
> > +				goto unregister_region_exit;
> > +			}
> >  		}
> >  	}
> >
> > --
> > 2.26.2

