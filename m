Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628AE26F1A4
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Sep 2020 04:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgIRCws (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Sep 2020 22:52:48 -0400
Received: from mga05.intel.com ([192.55.52.43]:6823 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbgIRCIH (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 17 Sep 2020 22:08:07 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 22:08:07 EDT
IronPort-SDR: 6bKn3Dde0GiiUGsA6ORywnj5CCj+8reWOMbNia28QnfVezqUwNoWmQpQ8XWezpjCXQ/0b1ZfBs
 3ovjyLP9FArw==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="244669135"
X-IronPort-AV: E=Sophos;i="5.77,273,1596524400"; 
   d="scan'208";a="244669135"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 19:00:53 -0700
IronPort-SDR: wfPS8bIfjjdzA8xRzcj3gcZAeQ6a6+TJsVhQV6PRxjvI4slpsmtAGppXUOxcUIUASdc5yJzIGl
 XH2D6UcOIsiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,273,1596524400"; 
   d="scan'208";a="346823777"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 17 Sep 2020 19:00:52 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 17 Sep 2020 19:00:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 17 Sep 2020 19:00:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 17 Sep 2020 19:00:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUEzwwHkM0H4bsRv9actY8KA/HHo6KXUHAnN8v4hHCpI58yUURCHvKtWubOvemb62D06QZwAUymHrR7dSd3oGLGeNKEvOlHfsWhRFCA94Y6HVlpnsCfU2G2gtJixwgb6+qiJyNs8E4dzQegVxEDmC5Tz+xHa4zKA+dyCFFa27l5wCSIV7MfVl6VY8yJAPG035hNldnDj1rXLyqtLUZARidurhAunybLyRy07T6IMdfsFAYz/MAnXtQuw+/TpPBmFsxsKLHsAJlVOejn6fxqnfFX5ZQOJSr1zAu56frD/XTeHHCyJXpztYRm+OI5NobVaXs/jf6cysujwyWFznQNgBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+TB/TBYho4Ifrp2gAloFqdLzoeOUshKAHKwGOYXxHs=;
 b=oYaJdGFfK04iVJMNsgIDQ7IquiEdrcmazXevoMS20oekRrEIEHSJs4uzKOZNZQd8Evw3EEfOz95Jmpimhtrl3rdc3+3fX5NzmAyG/dvprsM4I6rYyDu0c+VOL2DrnblenwmwpXGpccEBUoecVXabFBjQftu1GU5ZtxQRnig6gFQrJvXQ5E5+mg+BbhZurvQK/h/i+G0zQ9zCYWBn0gOHd+WmMYF72YggIAKQGzEZQUOPUkXWOLPWo8ZZpEOavNHyUS6cm9lx0uvQT7ekDHZbTUQRKNG3u/+eT6//f39CNF7ziMYCXWViXEiRU4WifUtvdeQfWW4n9u7fez4VILoovQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+TB/TBYho4Ifrp2gAloFqdLzoeOUshKAHKwGOYXxHs=;
 b=M7TTVe1NBvB7WeOONaan8G34PaMc+VR3ESnK3kbyTPZwo2rPny3RTyCNAGX+ikiBjLUl6z8yQOkw4Ejytms46vs3HsgNfxq65lHPXjKC5CBK1E6SXiH2QWWvctHTnpsAjZb065R5aG+u0ZGddMH5KQ0+4vHPCvOqY8XekRop+7c=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3242.namprd11.prod.outlook.com (2603:10b6:5:5b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Fri, 18 Sep
 2020 02:00:43 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7823:516e:1ec4:a60d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7823:516e:1ec4:a60d%5]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 02:00:42 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>
CC:     "Weight, Russell H" <russell.h.weight@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>
Subject: RE: [PATCH v2 1/1] fpga: dfl: afu: harden port enable logic
Thread-Topic: [PATCH v2 1/1] fpga: dfl: afu: harden port enable logic
Thread-Index: AQHWjSD4LeMXUYhU00yzPOyYE3T3saltR+oAgAATsACAAEY/AA==
Date:   Fri, 18 Sep 2020 02:00:42 +0000
Message-ID: <DM6PR11MB3819EE8D1193AA51A50EE14E853F0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20200917183219.3603-1-russell.h.weight@intel.com>
 <7f181203-c164-4e6e-c710-1096b0aa13b8@redhat.com>
 <20200917213850.GA30570@archbook>
In-Reply-To: <20200917213850.GA30570@archbook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 337fcf86-e269-43a3-bdab-08d85b76a674
x-ms-traffictypediagnostic: DM6PR11MB3242:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB324273E6F5912186987023CB853F0@DM6PR11MB3242.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eNgoJ5NnZveedq4WNbXMT82916+E605uf/+YqdMVEuWBgxb6IwIMQEbQOTacSsTeFzNeDVi02/4R3xWK98gQmWVjDa7Gnk2ZXJGPck8+H/UloH9u6OmH3P6z/2leDBYoZPl+Oc9AtKSjeVdgWuOT8gvFnejIDz4MJh8TKU+o2K+Fx07fBSx6lnpKEsauA4KoIc+BY5SdWYbnvDisrBXl6JHUz5qUeZhn9N+CTTgo7rUcpzbtByJ+319BWCx9blCl9Dvb/CFf9oCvt2M8SMUMcAcLy/pYUY7VXbPzvePElV5952lA2v9e6/2bv+/y354GRNG89947g9k9qEmvcsW+zsUe6Un32ysJa6TPx9DfOYW6qx66JWqJRCUrhdP5oMUk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(2906002)(4326008)(478600001)(53546011)(110136005)(55016002)(8936002)(316002)(33656002)(7696005)(6506007)(26005)(54906003)(186003)(83380400001)(8676002)(52536014)(71200400001)(86362001)(107886003)(66946007)(76116006)(66446008)(9686003)(66556008)(66476007)(64756008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: BJ4brxhsEBjIr+q/Kf3pEtMoBvFEtZW41ED5Q93q8e6RUTo9zkWsdc6gk4hbAGXZdTTpFDCS/Aewde9OTY2Ywwud1VDPRGOFTfFmolBjTdFPWwFSiq7enqE8PhII8NDKNLY34xDEHePKP6d28hD0h4COG3HksHsNpc56rpQEOuM3NtZTiCseKJj1Um8okpFz5/iXms0xoKaQ0/P4iSm5k/QKWFEuGzygizoNK+MG0W8Wjhr0+YLkxZdRmTSxmr7/ib285e3P1fF3yGWkGxgi6fT/XB0nH5d+0CfjZHt2jLQjY3GuZg4xd4NTOKt+wdxn+81yBtf5EVxoERUFgNoLRVfiaI2AqcB/vHTYOYZXpahARPckVlDl5A/MBEAh690YaipFT1SzpLTcHIIWUFRVahMHDN5kplIvbGHgFvEpStKjAX1BOCNL/qYBBPQ9vjvkrqANu96DcCFWeq+1VZCqBUztQ5LsiGp+JzJ086UR24m7L8hTZJlQcAkT23yPz5LH3a57rJxNOYZllHg3W7aRCwF4UDA0z5KS2ESXIpCPoio4hCjIJegU/K9kejBrgjx+AxrEGcOxsmrPBZcfoW+2XIoXAo8QheZWZYb97+PV9DSISggf1vZUUm8zYjWXjNaKlgmuGK1fZKNTGQUnGrB8iw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 337fcf86-e269-43a3-bdab-08d85b76a674
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 02:00:42.7413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k+7LDv8T7nLKcOT4PpYl43UJ+3ZbxX6/S3DQGOvIflJqeS9D3+qLT5HNEJnhiV44ZWWTa1odDQozFFFG9sAK8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3242
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: Re: [PATCH v2 1/1] fpga: dfl: afu: harden port enable logic
>=20
> On Thu, Sep 17, 2020 at 01:28:22PM -0700, Tom Rix wrote:
> >
> > On 9/17/20 11:32 AM, Russ Weight wrote:
> > > Port enable is not complete until ACK =3D 0. Change
> > > __afu_port_enable() to guarantee that the enable process
> > > is complete by polling for ACK =3D=3D 0.
> > >
> > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> General note: Please keep a changelog if you send updated versions of a
> patch. This can be added here with an extra '---' + Text between Signed-o=
ff
> and
> diffstat:
>=20
> ---
> Changes from v1:
> - FOo
> - Bar
> > > ---
> > >  drivers/fpga/dfl-afu-error.c |  2 +-
> > >  drivers/fpga/dfl-afu-main.c  | 29 +++++++++++++++++++++--------
> > >  drivers/fpga/dfl-afu.h       |  2 +-
> > >  3 files changed, 23 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-erro=
r.c
> > > index c4691187cca9..0806532a3e9f 100644
> > > --- a/drivers/fpga/dfl-afu-error.c
> > > +++ b/drivers/fpga/dfl-afu-error.c
> > > @@ -103,7 +103,7 @@ static int afu_port_err_clear(struct device *dev,
> u64 err)
> > >  	__afu_port_err_mask(dev, false);
> > >
> >
> > There is an earlier bit that sets ret =3D -EINVAL.
> >
> > This error will be lost or not handled well.
> >
> > Right now it doesn't seem to be handled.
>=20
> Ultimately you'd want to report *at least* one of them, the current code
> seems to continue and enable the port either case. Is that what it
> should be doing?

In order to do error clear, we have to put port into reset firstly and then
clear port after error clearing is done. If we see failure during error cle=
aring
that we still want to get the port back to work at least. As we know, if
port is still in reset, then the accelerator connected to the port won't wo=
rk.

>=20
> Is the timeout more severe than the invalid value? Do you want to print
> a warning?

Yes, It's a very bad case if port can not be enabled any more (accelerator =
may
not be accessible any more), hardware should already be in error, it's bett=
er
we have some warning messages here.

>=20
> Either way a comment explaining why this is ok would be appreciated :)
> >
> > >  	/* Enable the Port by clear the reset */
> > > -	__afu_port_enable(pdev);
> > > +	ret =3D __afu_port_enable(pdev);
> > >
> > >  done:
> > >  	mutex_unlock(&pdata->lock);
> > > diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.=
c
> > > index 753cda4b2568..f73b06cdf13c 100644
> > > --- a/drivers/fpga/dfl-afu-main.c
> > > +++ b/drivers/fpga/dfl-afu-main.c
> > > @@ -21,6 +21,9 @@
> > >
> > >  #include "dfl-afu.h"
> > >
> > > +#define RST_POLL_INVL 10 /* us */
> > > +#define RST_POLL_TIMEOUT 1000 /* us */
> > > +
> > >  /**
> > >   * __afu_port_enable - enable a port by clear reset
> > >   * @pdev: port platform device.
> > > @@ -32,7 +35,7 @@
> > >   *
> > >   * The caller needs to hold lock for protection.
> > >   */
> > > -void __afu_port_enable(struct platform_device *pdev)
> > > +int __afu_port_enable(struct platform_device *pdev)
> > >  {
> > >  	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> >dev);
> > >  	void __iomem *base;
> > > @@ -41,7 +44,7 @@ void __afu_port_enable(struct platform_device
> *pdev)
> > >  	WARN_ON(!pdata->disable_count);
> > >
> > >  	if (--pdata->disable_count !=3D 0)
> > > -		return;
> > > +		return 0;
> > Is this really a success ? Maybe -EBUSY ?
> Seems like if it's severe enough for a warning you'd probably want to
> return an error.

As Yilun mentioned, this is just a reference count operation, we don't
need to return error code.

> > >
> > >  	base =3D dfl_get_feature_ioaddr_by_id(&pdev->dev,
> PORT_FEATURE_ID_HEADER);
> > >
> > > @@ -49,10 +52,20 @@ void __afu_port_enable(struct platform_device
> *pdev)
> > >  	v =3D readq(base + PORT_HDR_CTRL);
> > >  	v &=3D ~PORT_CTRL_SFTRST;
> > >  	writeq(v, base + PORT_HDR_CTRL);
> > > -}
> > >
> > > -#define RST_POLL_INVL 10 /* us */
> > > -#define RST_POLL_TIMEOUT 1000 /* us */
> > > +	/*
> > > +	 * HW clears the ack bit to indicate that the port is fully out
> > > +	 * of reset.
> > > +	 */
> > > +	if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
> > > +			       !(v & PORT_CTRL_SFTRST_ACK),
> > > +			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
> > > +		dev_err(&pdev->dev, "timeout, failure to enable device\n");
> > > +		return -ETIMEDOUT;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > >
> > >  /**
> > >   * __afu_port_disable - disable a port by hold reset
> > > @@ -111,7 +124,7 @@ static int __port_reset(struct platform_device
> *pdev)
> > >
> > >  	ret =3D __afu_port_disable(pdev);
> > >  	if (!ret)
> > > -		__afu_port_enable(pdev);
> > > +		ret =3D __afu_port_enable(pdev);
> > >
> > >  	return ret;
> > >  }
> > > @@ -872,11 +885,11 @@ static int afu_dev_destroy(struct
> platform_device *pdev)
> > >  static int port_enable_set(struct platform_device *pdev, bool enable=
)
> > >  {
> > >  	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> >dev);
> > > -	int ret =3D 0;
> > > +	int ret;
> > >
> > >  	mutex_lock(&pdata->lock);
> > >  	if (enable)
> > > -		__afu_port_enable(pdev);
> > > +		ret =3D __afu_port_enable(pdev);
> > >  	else
> > >  		ret =3D __afu_port_disable(pdev);
> > >  	mutex_unlock(&pdata->lock);
> > > diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
> > > index 576e94960086..e5020e2b1f3d 100644
> > > --- a/drivers/fpga/dfl-afu.h
> > > +++ b/drivers/fpga/dfl-afu.h
> > > @@ -80,7 +80,7 @@ struct dfl_afu {
> > >  };
> > >
> > >  /* hold pdata->lock when call __afu_port_enable/disable */
> > > -void __afu_port_enable(struct platform_device *pdev);
> > > +int __afu_port_enable(struct platform_device *pdev);
> > >  int __afu_port_disable(struct platform_device *pdev);
> >
> > The other functions in this file have afu_*=A0 since the
> __afu_port_enable/disable
> >
> > are used other places would it make sense to remove the '__' prefix ?
>=20
> The idea on those is to indicate that the caller need to be cautious
> (often a lock / mutex) is required. I think keeping them as is is fine.

Yes. That's why we add the prefix for these functions.

Thanks
Hao

>=20
> >
> > If you think so, maybe a cleanup patch later.
> >
> > Tom
> >
> > >
> > >  void afu_mmio_region_init(struct dfl_feature_platform_data *pdata);
> >
>=20
> Thanks,
> Moritz
