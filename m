Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC91F269D8D
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Sep 2020 06:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgIOEmd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Sep 2020 00:42:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:27128 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgIOEmb (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 15 Sep 2020 00:42:31 -0400
IronPort-SDR: rfoW8Z/F3VkFKAy7lYkNlvKBYc7yAted6Pu8Atz6XsBFdyjqlUhBUzpawlFWfsInJgfYKlQWrY
 cBdxGpzVwcog==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="220755712"
X-IronPort-AV: E=Sophos;i="5.76,428,1592895600"; 
   d="scan'208";a="220755712"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 21:42:30 -0700
IronPort-SDR: rcuSg/kkZCTIDdgnueVUQbLfyDaA6xSNNaisJsoRc0YpSHllt6f4G6GzoywK/zSruoGsFs65oB
 XaPbkZXUxo5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,428,1592895600"; 
   d="scan'208";a="451149285"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 14 Sep 2020 21:42:30 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 14 Sep 2020 21:42:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 14 Sep 2020 21:42:30 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 14 Sep 2020 21:42:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UukjZxTzgEKBURjtwO9RfYqKfALfXqqxvrhB4scZtuf5YNOK6yHB42cwcW99d7xNzvFNQCJ/J0fwivXcVCmIFlcufaueDqFcvTELECjIa7hs78LNeerfRPq2VZunM1tktYXkSXoKNNw631S3EPQwZjxhcfHK9trZaHZOw5JrO6DDi91mEKO7nOFoEVZtPVAE9jNhoIi9IF1LkKFCe3WHok3m3BBMqP5Rv3sRdjdPoYcaR5EKLqJCZyYln8uY5X0Z2gQimo+5EPIvWLYvo45DQ6GB1zNrQbxdVoHdhVQlcM6euAZpENnT4HkufWo/Xcqa4fz2br2rE5289MC+6MYCjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFOl0tG3+4I6PCvDu6oTyTwueG9ifVOw9SC8l0yJ8No=;
 b=La1PZmc9HqWfBdWBpHPtNoYBhmXLBKBzKRw7YGw2rkSPEcLdOaq3b0fpnTMto3FusiWQW9nc60RcsW7cuAf8jDJ+2y/5sQxmY7kNXuwFPuREZpJSRboRYDD5GYGw2elMnbJqQmW26nyJvkYW73LL5Il0mWqEeSclTfFb+dLNPkEwzi1yKjbvexVez8K/9u/GZuD63GfM15/lxneqqiYfLSyKHxJmzh81znIJ1cFNKrK05jHPoXnq7Rq0q15KXXJa46ouCHZLqWeU2YRBWAqfboH95GjTriko9Uq+R9HMeBJ+VtMcUux3dzvnfRMOE/bpt0Gp9OewSL2yWeHvg8E0DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFOl0tG3+4I6PCvDu6oTyTwueG9ifVOw9SC8l0yJ8No=;
 b=Y+Ws6IwmXprjdHhLrK76zVcuNyrAE5QVU0zlXwQAfr0lr/fC3EOth31vBflajGTJ3Wgv5ZqsFqdvHiaH97LwoqJHR2/hIfGdStI60ZyAdzfmNyWIUdr2WrnDSbOTsMBPfO50hNFOPru1Pc99lgJ7XSB1yjQ2N5Y31IxW4n7sdds=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB2890.namprd11.prod.outlook.com (2603:10b6:5:63::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.18; Tue, 15 Sep
 2020 04:42:23 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7823:516e:1ec4:a60d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7823:516e:1ec4:a60d%5]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 04:42:23 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>
CC:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>
Subject: RE: [PATCH v2 3/4] fpga: dfl: fix the comments of type & feature_id
 fields
Thread-Topic: [PATCH v2 3/4] fpga: dfl: fix the comments of type & feature_id
 fields
Thread-Index: AQHWixDtrA5L4+1890mnZ9B/q81u0alpEymAgAALpJA=
Date:   Tue, 15 Sep 2020 04:42:22 +0000
Message-ID: <DM6PR11MB381993E3210D83554558683A85200@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1600140473-12351-1-git-send-email-yilun.xu@intel.com>
 <1600140473-12351-4-git-send-email-yilun.xu@intel.com>
 <20200915035945.GC2217@epycbox.lan>
In-Reply-To: <20200915035945.GC2217@epycbox.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2d77324-8fb1-49e1-25f3-08d85931bcfa
x-ms-traffictypediagnostic: DM6PR11MB2890:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB289078E8CE90DF769BC8437585200@DM6PR11MB2890.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R0lR79q0xGj5k5zyCWWZ+X199E4/oed/tsYssjXdqJ4QyQH3SB84tbk0CFS+h3mPx+eo/rxfHhxhuh0NrIxhox+qQ1EHMIRTSRSZd+aXiNszJWvdTM7ixL/n7LpQ+3Mwb7HTONWYHCz11b/go8fhaZRrrAb9MK0hFTM1n9bjUTs+8sDHRmZor19FSCpBbrhKn6X4G4qZmB0KklDauo5uJMJWWae0/goMmRv8hKArgljyf8LCOREoBI2VEsUsehDP55Mv4V2GJM4/mPuNw62wB7MhCrCLzg/2oLmiNaJUKwhR/INJ2V6Z5ll2PdP9y5eoLfkhmPPLZwuSWc4c3pwb1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(55016002)(9686003)(71200400001)(110136005)(316002)(26005)(186003)(33656002)(54906003)(7696005)(8676002)(8936002)(66946007)(76116006)(66476007)(5660300002)(83380400001)(2906002)(86362001)(66446008)(6506007)(52536014)(66556008)(6636002)(478600001)(4326008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: KDFZpmJhlD16FdyM+xnvHp27dHS1eOW6at0W6JE6dR7TIH3T4KisQk1+F65oSlL5fNULJLlHZlJR/8TdRSGqfelXWR78XpgZStk9LsnnUU7neG+zk02MU8NvBNh0oYj70czwJYqCNdzz34cOlTuID3+jzhI1L2kFnlHrSkwZf2E9GCPXpmbGSpCX1bsltoa0o380W3lahOj9TCcW6OBNMrQ+/m+0u3J6xeY50B/pwC2ihJ5LNOaFlKHUZvs9XaVhaA5aWW3a302yFHIybj31/nA8OJnswMgU06BCM2056Ly4uFPt7yRfW7mbFLOIsQ1JWSE40ItxcYVKCkAOBEUqIvyv3c/lzzxBWMcn9+rtXhOQa+ZKlxknobisxNsFdzfpTeB/lxUZSg4DzoALttf44MaoUj7wlRSqQG6x3HTX/aV5yZTv5AauGKTWWcat76dz24X7wtWHX1QfjYDNYbG7njPsiZzFqWG5KhsXs3AOW+VXfh0kuFmdfQN80fyWGvRm5DYUIAPeazWXXKnzoTUbnSlhEseOo2I3pHUWZNfBftvbES5gkOjT/rvJnwJ4tS33ZdoSkThGPoVZX9TXMEq4GpkrjJAPN//5A3gEVVm5QwCT4Jg4IYpGPxlBU9KPBJfC+FK2QcdwziqP59GWkOCMvw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d77324-8fb1-49e1-25f3-08d85931bcfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 04:42:22.9956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WCdWy8SzfL/vRM2u2Pd6zvThFehHSmeo+Zs+aPL6mj/8VessPwP5xSjetKmH/gre9kWnskGoo8uAQ6SBp5rS5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2890
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> On Tue, Sep 15, 2020 at 11:27:52AM +0800, Xu Yilun wrote:
> > The description of feature_id in struct dfl_device is not accurate. In
> > DFL specification the feature_id is the 12 bits field. The description
> > in struct dfl_device_id is more clear so we make them aligned. We also
> > made the similar fix for the type field.
> >
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>

Acked-by: Wu Hao <hao.wu@intel.com>

Thanks
Hao

> > ---
> >  drivers/fpga/dfl.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> > index 3c69596..d5e050a 100644
> > --- a/drivers/fpga/dfl.h
> > +++ b/drivers/fpga/dfl.h
> > @@ -531,8 +531,8 @@ enum dfl_id_type {
> >   *
> >   * @dev: generic device interface.
> >   * @id: id of the dfl device.
> > - * @type: type of DFL FIU of the device. See enum dfl_id_type.
> > - * @feature_id: 16 bits feature identifier local to its DFL FIU type.
> > + * @type: contains 4 bits DFL FIU type of the device. See enum dfl_id_=
type.
> > + * @feature_id: contains 12 bits feature identifier local to its DFL F=
IU type.
> >   * @mmio_res: mmio resource of this dfl device.
> >   * @irqs: list of Linux IRQ numbers of this dfl device.
> >   * @num_irqs: number of IRQs supported by this dfl device.
> > --
> > 2.7.4
> >
>=20
> Applied to for-next,
>=20
> Thanks
