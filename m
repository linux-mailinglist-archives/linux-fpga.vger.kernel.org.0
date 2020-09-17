Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5207426E77C
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Sep 2020 23:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgIQVix (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Sep 2020 17:38:53 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40507 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgIQVix (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 17 Sep 2020 17:38:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id bd2so1820857plb.7;
        Thu, 17 Sep 2020 14:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DQO2QRePQlXia+QUwE8Gms1jAKPwrC5Qe3OxLi8PShE=;
        b=G3n2Q6vqPcrDqw0MkX4uqqODpzHEeKopGNNNNPzLFzhmRn0ItxDBVkRJPiPPIfQw9e
         PaG7s/cIZI7e3/UE3KpGRN30XAn+La3a+OF9eh7adb3FE+hi3JYa/dYFUiUNk3pq1Wyc
         ydGKCDwI31/42iuVRrq93Oy1kS7jVnHAqqC/XqeJhvYUdzco3RTxRkRKPMblTB8oSLD4
         UtDzmNHkIyshPzbXa8AAUx4KiSvhtWmK15YlwoBN7leQ2jpyLJsxViGHZQoWvYCwtmCn
         mjpK7hjTIueOAaIHg3fDx779cBQksDRe22Uei7ynftAmUSs8tEOgOApv0kf0AB27rk4n
         SfNw==
X-Gm-Message-State: AOAM5312h9+aUb779J+pPjgpARiW4DrtcW9xcEiLIqebEPiQEUMnktBe
        as9lpGolkgDww4DnGgmHjrg=
X-Google-Smtp-Source: ABdhPJy9tI1kYYlurN/DC7b21ka7aeE44Qh2Bs0MiFQUvmjkt1WSeRd/hJ1p+SAibgsgvWZfXURznw==
X-Received: by 2002:a17:902:e9d3:b029:d1:f370:1e90 with SMTP id 19-20020a170902e9d3b02900d1f3701e90mr8082063plk.76.1600378732449;
        Thu, 17 Sep 2020 14:38:52 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id c7sm615323pfj.100.2020.09.17.14.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 14:38:51 -0700 (PDT)
Date:   Thu, 17 Sep 2020 14:38:50 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
Subject: Re: [PATCH v2 1/1] fpga: dfl: afu: harden port enable logic
Message-ID: <20200917213850.GA30570@archbook>
References: <20200917183219.3603-1-russell.h.weight@intel.com>
 <7f181203-c164-4e6e-c710-1096b0aa13b8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f181203-c164-4e6e-c710-1096b0aa13b8@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Sep 17, 2020 at 01:28:22PM -0700, Tom Rix wrote:
> 
> On 9/17/20 11:32 AM, Russ Weight wrote:
> > Port enable is not complete until ACK = 0. Change
> > __afu_port_enable() to guarantee that the enable process
> > is complete by polling for ACK == 0.
> >
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
General note: Please keep a changelog if you send updated versions of a
patch. This can be added here with an extra '---' + Text between Signed-off and
diffstat:

--- 
Changes from v1:
- FOo
- Bar
> > ---
> >  drivers/fpga/dfl-afu-error.c |  2 +-
> >  drivers/fpga/dfl-afu-main.c  | 29 +++++++++++++++++++++--------
> >  drivers/fpga/dfl-afu.h       |  2 +-
> >  3 files changed, 23 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
> > index c4691187cca9..0806532a3e9f 100644
> > --- a/drivers/fpga/dfl-afu-error.c
> > +++ b/drivers/fpga/dfl-afu-error.c
> > @@ -103,7 +103,7 @@ static int afu_port_err_clear(struct device *dev, u64 err)
> >  	__afu_port_err_mask(dev, false);
> >  
> 
> There is an earlier bit that sets ret = -EINVAL.
> 
> This error will be lost or not handled well.
> 
> Right now it doesn't seem to be handled.

Ultimately you'd want to report *at least* one of them, the current code
seems to continue and enable the port either case. Is that what it
should be doing? 

Is the timeout more severe than the invalid value? Do you want to print
a warning?

Either way a comment explaining why this is ok would be appreciated :)
> 
> >  	/* Enable the Port by clear the reset */
> > -	__afu_port_enable(pdev);
> > +	ret = __afu_port_enable(pdev);
> >  
> >  done:
> >  	mutex_unlock(&pdata->lock);
> > diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> > index 753cda4b2568..f73b06cdf13c 100644
> > --- a/drivers/fpga/dfl-afu-main.c
> > +++ b/drivers/fpga/dfl-afu-main.c
> > @@ -21,6 +21,9 @@
> >  
> >  #include "dfl-afu.h"
> >  
> > +#define RST_POLL_INVL 10 /* us */
> > +#define RST_POLL_TIMEOUT 1000 /* us */
> > +
> >  /**
> >   * __afu_port_enable - enable a port by clear reset
> >   * @pdev: port platform device.
> > @@ -32,7 +35,7 @@
> >   *
> >   * The caller needs to hold lock for protection.
> >   */
> > -void __afu_port_enable(struct platform_device *pdev)
> > +int __afu_port_enable(struct platform_device *pdev)
> >  {
> >  	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> >  	void __iomem *base;
> > @@ -41,7 +44,7 @@ void __afu_port_enable(struct platform_device *pdev)
> >  	WARN_ON(!pdata->disable_count);
> >  
> >  	if (--pdata->disable_count != 0)
> > -		return;
> > +		return 0;
> Is this really a success ? Maybe -EBUSY ?
Seems like if it's severe enough for a warning you'd probably want to
return an error.
> >  
> >  	base = dfl_get_feature_ioaddr_by_id(&pdev->dev, PORT_FEATURE_ID_HEADER);
> >  
> > @@ -49,10 +52,20 @@ void __afu_port_enable(struct platform_device *pdev)
> >  	v = readq(base + PORT_HDR_CTRL);
> >  	v &= ~PORT_CTRL_SFTRST;
> >  	writeq(v, base + PORT_HDR_CTRL);
> > -}
> >  
> > -#define RST_POLL_INVL 10 /* us */
> > -#define RST_POLL_TIMEOUT 1000 /* us */
> > +	/*
> > +	 * HW clears the ack bit to indicate that the port is fully out
> > +	 * of reset.
> > +	 */
> > +	if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
> > +			       !(v & PORT_CTRL_SFTRST_ACK),
> > +			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
> > +		dev_err(&pdev->dev, "timeout, failure to enable device\n");
> > +		return -ETIMEDOUT;
> > +	}
> > +
> > +	return 0;
> > +}
> >  
> >  /**
> >   * __afu_port_disable - disable a port by hold reset
> > @@ -111,7 +124,7 @@ static int __port_reset(struct platform_device *pdev)
> >  
> >  	ret = __afu_port_disable(pdev);
> >  	if (!ret)
> > -		__afu_port_enable(pdev);
> > +		ret = __afu_port_enable(pdev);
> >  
> >  	return ret;
> >  }
> > @@ -872,11 +885,11 @@ static int afu_dev_destroy(struct platform_device *pdev)
> >  static int port_enable_set(struct platform_device *pdev, bool enable)
> >  {
> >  	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> > -	int ret = 0;
> > +	int ret;
> >  
> >  	mutex_lock(&pdata->lock);
> >  	if (enable)
> > -		__afu_port_enable(pdev);
> > +		ret = __afu_port_enable(pdev);
> >  	else
> >  		ret = __afu_port_disable(pdev);
> >  	mutex_unlock(&pdata->lock);
> > diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
> > index 576e94960086..e5020e2b1f3d 100644
> > --- a/drivers/fpga/dfl-afu.h
> > +++ b/drivers/fpga/dfl-afu.h
> > @@ -80,7 +80,7 @@ struct dfl_afu {
> >  };
> >  
> >  /* hold pdata->lock when call __afu_port_enable/disable */
> > -void __afu_port_enable(struct platform_device *pdev);
> > +int __afu_port_enable(struct platform_device *pdev);
> >  int __afu_port_disable(struct platform_device *pdev);
> 
> The other functions in this file have afu_*  since the __afu_port_enable/disable
> 
> are used other places would it make sense to remove the '__' prefix ?

The idea on those is to indicate that the caller need to be cautious
(often a lock / mutex) is required. I think keeping them as is is fine.

> 
> If you think so, maybe a cleanup patch later.
> 
> Tom
> 
> >  
> >  void afu_mmio_region_init(struct dfl_feature_platform_data *pdata);
> 

Thanks,
Moritz
