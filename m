Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FA73AAEDB
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Jun 2021 10:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFQIga (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Jun 2021 04:36:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:24942 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhFQIg1 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 17 Jun 2021 04:36:27 -0400
IronPort-SDR: 29WV+KNJhblaxIevodIDadYEGGGcE/2jcGMR24q7J3o1QL4AEK20BlatEKxYEjdKCkzDQJLOvl
 7ABxA5VoCjqg==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="291960789"
X-IronPort-AV: E=Sophos;i="5.83,280,1616482800"; 
   d="scan'208";a="291960789"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 01:34:19 -0700
IronPort-SDR: cnd2chz6DCp9kBa4Xwsk2+Gdw8hHqdEJI+s+2afcrCRCrz0/dOX+zsMcnbEIPEwsuA0lgApTLi
 00B5Q7IkGDug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,280,1616482800"; 
   d="scan'208";a="452700883"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jun 2021 01:34:19 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 17 Jun 2021 01:34:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Thu, 17 Jun 2021 01:34:18 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Thu, 17 Jun 2021 01:34:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqFvavJpW5ENk6PIinxVb3XJ9zVFwKwLFaoJof1UbeNydLueNVeHCPNnMl8qyp4wirmDAzJtfq1JotZ+BR/LhW9/gSgMVWDttPuBk+qeCVKowC5+kcc1EGs2z9msylmECxMjMH5H6Zg3nkS5AV8k9Zn2B5J6cwMe0sQKnjC96UrN4OYYvW+Ig++lOiPDAw1q2S/rQ+4XwxQ5pXD+6wZmc1EVCD70rr8whKPijThR/RW9/UJlv0EULPHUV3hxf8b+7HRj64mnNxVk8/YBHnjmqyxdBhbL+vmWhOHq8wUIyicGt52fBM8nwo5HkDfFjV+To4G2SyVFDlECVrCo+k0U0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1BmaEO1REdaWCgdj9mgzndlLh2AKi2MtAUj5Vbquwc=;
 b=U1FwerdOPBkG2qLmmN32VWCRs2bOyhqm2MVKUNPkEGnt3dkqXOg9Z5pVgxn8eFE7kAFsyhxFm/rJfGtwvQ1BL8q7JHzPotz295JGTtztGp/bFyGf8tKDi4o2hwnDWmi/ayV9tdb6gS5giru0I9IFQ9pM4J5YHlQEVfdnNmWT3bPqRuVPVITn+ui+51Qi3EDx4TqUtuV+Ac1GVJ8S0lO8OWZIa5jQHXbcCbhe8zw7MAW9k6Ghc+8hXgJl592kWeROFp/UF+OHzTX4vzPndN+hY/NlKVWWPeUeGp7jaRE8ItJtvb5HEiiPucMDAnKRPRKUSi7MfKz5xfqNJY4p0Us1cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1BmaEO1REdaWCgdj9mgzndlLh2AKi2MtAUj5Vbquwc=;
 b=jv4xrGVKdAy4/tnusrxh/T/iY4c3iZsx/uAyQel8wMT6RMmnz7PXH2Q6hawQzP7/VVsO1MTEHw9AXD7qt++3AhXAhrPGf+StRCnUHcNH/UyDnrJgdePv4FZ99TJcK8HHrgMVTnFpJqj2y7xmSpIoiJbFCB4NCYL8lMQngV9F+HA=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3243.namprd11.prod.outlook.com (2603:10b6:5:e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.19; Thu, 17 Jun 2021 08:34:15 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b%6]) with mapi id 15.20.4219.026; Thu, 17 Jun 2021
 08:34:15 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
CC:     Tom Rix <trix@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "krzysztof.kozlowski@canonical.com" 
        <krzysztof.kozlowski@canonical.com>,
        "nava.manne@xilinx.com" <nava.manne@xilinx.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "davidgow@google.com" <davidgow@google.com>,
        "fpacheco@redhat.com" <fpacheco@redhat.com>,
        "Gong, Richard" <richard.gong@intel.com>,
        "luca@lucaceresoli.net" <luca@lucaceresoli.net>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 1/4] fpga: dfl: reorganize to subdir layout
Thread-Topic: [PATCH v4 1/4] fpga: dfl: reorganize to subdir layout
Thread-Index: AQHXYVpMuuq4CCKpI0OAe3HAOe9lxqsUps2ggADmEgCAAEctkIABz+UAgAA0T8A=
Date:   Thu, 17 Jun 2021 08:34:15 +0000
Message-ID: <DM6PR11MB381924F43550A6699CB55213850E9@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20210614201648.3358206-1-trix@redhat.com>
 <20210614201648.3358206-3-trix@redhat.com>
 <DM6PR11MB381964374223D0D2958AFA6985309@DM6PR11MB3819.namprd11.prod.outlook.com>
 <d64b0fb8-5f83-2995-7ee9-b4ed2932ef60@redhat.com>
 <DM6PR11MB3819259241791EB04A2CB9C8850F9@DM6PR11MB3819.namprd11.prod.outlook.com>
 <YMrS9OUSaCdtGwrE@epycbox.lan>
In-Reply-To: <YMrS9OUSaCdtGwrE@epycbox.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.143.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 756587bf-43ca-4b0e-2014-08d9316ab0e4
x-ms-traffictypediagnostic: DM6PR11MB3243:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB32437929E9818C9DD9855214850E9@DM6PR11MB3243.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tJFh9znL/BGrQGP+gv1xKKfuO6o6lnRuX3AGHvzzEdUjvxDJtQkxH/PqdCIcm/Gxemq9G8w9OnHbKaHhkRXy4IbpwEoLetVKlP76p6z5928l8inhCa4uEra/j85oun39EXTVmXbc8XHI/FBiLzr2ktG9jCcrmqpGxcMlUkVezzHl+bL9aqT2uD7YZWvhaM4MXlTO5qOtMlN+MdIvvkkW+jbB5u7YGrisL37Yf9T80rFaVgQZ80CGSpu2MfGTo4pPea/83fQBI3fLySNdDd1Nja0BkyXtJ7l0qdLpycs8ispp0jjhKBBo78IxDvcv2i26BMQRmhGvavK9el5R7eEFPRkLm/cdHJGnZTV9KGzKAmxHH7kjQ3sAcejn1D8WKG4VL90aCnFs+IYGVNPqe2o+MdlSfKhHsmCY2vhQUumfrjaAG3zATeBh1IFNKmh/EstHuQHacnz8SmuvikxNAolF956wqiquhJHmYj+kxH2DbXPJB9abXCkU2IybIT15Sanavuqeqf2MFpFx4cHGFV0RtAfllLa7QJU1nxUkLERDo1WPYlFfxcOvsyhEeQihtb44tgKcgqodjS6hIeqTpKxeJSVnpDCVFHyniaIpOclwdxg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(71200400001)(86362001)(54906003)(8676002)(55016002)(26005)(8936002)(186003)(2906002)(7696005)(498600001)(64756008)(53546011)(4326008)(66446008)(6506007)(76116006)(66476007)(66556008)(5660300002)(9686003)(52536014)(7416002)(6916009)(66946007)(122000001)(33656002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lt7pYXZx8ymj+C3XZLCcDZ82vXEVshWrDXVIhngYvqYaxPZgqqUDHbPvGpYi?=
 =?us-ascii?Q?5ARVcv6dCaawwyhCEWWacXect5ZoDBIHdFN2MPa0LdkU504TI5TjywZpdFMU?=
 =?us-ascii?Q?9rqBqtrwtu+aqBIKlZNch/bmlIXdMZxDv1dCwS22yHbtMbtOUh1//pD+ToVH?=
 =?us-ascii?Q?eJx0ebc7D/ya6QfCCptYUlUPyJPLHMkw1KByPMXtJPKrfEr1fcTihJp0WUIl?=
 =?us-ascii?Q?j7oSNT/QYrwNo8d7H1a1MzDjp6SLqteSJRGfUaMhz2AYA2GVDBQIX/JHZQ/M?=
 =?us-ascii?Q?f6NoGauYUJlRAnDHD3Ig2zS2a9Pdsenxdf9PUfzmHB4ErwVQ+ZBcl9Kye7hI?=
 =?us-ascii?Q?+6ibZbpEj9H6hnGJtMyTOndSwVpqGfscI3xpnJY4rxGSJ7tucsf4+rPUp+vL?=
 =?us-ascii?Q?FAWRf2/Px3bIAciZSE5kIomJAoumb+1MmMnFTcOvFqR421OYIJ9fKbfzsn6B?=
 =?us-ascii?Q?9byqyIgEdzekAUZq9LiVGI9Qn7oASTBwFhj8V+3WUnPTNNnx+PYBL5mHpljI?=
 =?us-ascii?Q?KvixH1veFGnlltUeHv9lLsBMOAG8zPPmS1upZDCjVmWF3AHcCFhyKy/IPjs4?=
 =?us-ascii?Q?Hi+YtT7Hnl2+09nGqsTWlOz+TBFqH40xkSMR94JHazkP3v0FsEkI3p9n3aBo?=
 =?us-ascii?Q?QYlxYkGInw/iSPnx2C8zwXI6zYqbpNCJ9ValwAjFhR41Bz9n1opZ1pkMO+9j?=
 =?us-ascii?Q?kFSFhTBu1eV0A8M6o8SueZ512xwe/JW1rAXheGiQ8SYKfLUKRM2ayQ9U7Ae/?=
 =?us-ascii?Q?wu0naryEAutJYTyQ+RrZyhDESktWzsV/2jMHzNd4CD+qwYzxg81NgnvxQlYo?=
 =?us-ascii?Q?BhMV2uuXm7kDidR/UAcmcYz/YK4bKS3CQSfOAP0mPeYEnGgScm7cedswrSQE?=
 =?us-ascii?Q?tzYX/hCijiWmsThJnoiuPmPgAHKRFLqvh6dt5IYSMNrnehJjI9hDWnCfgJS9?=
 =?us-ascii?Q?03CMvOn0AzsfpgnHwxuZ4Hg27Kf2uuzKhW6lFzRLb5O8+DRXKxIOo8CD4Iwu?=
 =?us-ascii?Q?6YMJdoFYXumKvtC+VeZ9zOXnbjMnQcMrlc4ceKsj+b4s+ZA8BvUFo+JCPI5E?=
 =?us-ascii?Q?zROSzzkS4NNq2jOy/sf4tqNA8fk3rB7YJK9Xc/y2pfMwCjdUyYTJAdG6fkNI?=
 =?us-ascii?Q?ywlG4435UB2VYYWmh5BnRtNbtrnik4l7Yi/VoKjDuB1Y9p9bYyAj5p7FOSQe?=
 =?us-ascii?Q?ntrm1HbpjnTi7rrNjCajO8VKJKUbqjIMj49MfaF5XY0q2ec9Y9gh1M4BH50Q?=
 =?us-ascii?Q?08nTlw3TQ83RningKVeJC96TqW+2VRLyJO32J3XkjQlRZ++tYPfJHILa9O4D?=
 =?us-ascii?Q?wEFG1I4DcxhouvWTElTrg1e/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 756587bf-43ca-4b0e-2014-08d9316ab0e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2021 08:34:15.2931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wBFFquyL7qkFY7kDFojUPUPAxQl+SX3fJ6Z9HIaYq2vlOBhYblLI81TFoVuOFkz7toGQP/555DItx4KuR7EG7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3243
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> On Wed, Jun 16, 2021 at 01:05:36AM +0000, Wu, Hao wrote:
> > > On 6/15/21 1:08 AM, Wu, Hao wrote:
> > > >> Subject: [PATCH v4 1/4] fpga: dfl: reorganize to subdir layout
> > > >>
> > > >> From: Tom Rix <trix@redhat.com>
> > > >>
> > > >> Follow drivers/net/ethernet/ which has control configs
> > > >> NET_VENDOR_BLA that map to drivers/net/ethernet/bla
> > > >> Since fpgas do not have many vendors, drop the 'VENDOR' and use
> > > >> FPGA_BLA.
> > > > Hi Tom,
> > > >
> > > > Thanks for this patch. : )
> > > >
> > > > DFL is not a vendor, but something can be shared/reused. It's possi=
ble that
> > > > other vendors reuse the same concepts and the drivers of DFL. If ve=
ndor
> > > > drivers need to be moved inside sub folders, then maybe it's better=
 to
> > > > leave DFL in the parent folder?
> > >
> > > xrt is also not a vendor, more a subdevice framework like dfl.
> > >
> > > I am not sure what you mean by other dfl vendors can you give an exam=
ple ?
> >
> > It's fine, but the description here is a little confusing on vendor/fra=
mework
> > handling. No other vendor so far, but it's possible, DFL can be used in
> > non-intel device, and related drivers can be reused as well. Then a fpg=
a
> > mgr driver depends on DFL, should be put inside dfl folder or new
> > vendor's subfolder?
> >
> > Hao
> >
>=20
> I'm somewhat neutral on this. If someone non-intel starts using DFL we co=
uld
> also
> move the common parts back ...

That's fine.

>=20
> That being said, I'm not super convinced we have to move stuff in the
> first place.

I remember that the first submission of our code is having everything insid=
e a sub
folder, but was suggested that to have everything moved out, this is why we=
 have
dfl files here now. To be honest, I have the similar feeling as you, I didn=
't see any
strong reason to make this something we must do, but both solutions should =
be
fine. : )

Thanks
Hao

>=20
> - Moritz
