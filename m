Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4AF841E63D
	for <lists+linux-fpga@lfdr.de>; Fri,  1 Oct 2021 05:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhJADg4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 30 Sep 2021 23:36:56 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:38895 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhJADgz (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 30 Sep 2021 23:36:55 -0400
Received: by mail-pl1-f175.google.com with SMTP id x4so5424053pln.5
        for <linux-fpga@vger.kernel.org>; Thu, 30 Sep 2021 20:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GpG8iyMT3tj1lMFMaz84nBEthwQkjkDrnco/J0hYGTo=;
        b=B2D+2YumMCCRc1eg2jlZysOwRK0gi8bu9SYA4PTt9F8jYnFq9uEn2czjN9+IK/QEC0
         AZgt1zcSHvJ4XUOZ0PttvA22dMXnbvYb20kj+bwflU834wHTyt9t5zO5RkjF8m/H1e9f
         GyaJB7kaaOJSN52kQ2c4PS3eONF/GOlBk7bwJts6PI/g69w0dUTuOdVizmZqu8pn72gY
         mHV1m+WhbshA8NBu3HeH0iJmRtRrw5Yj2Z9jQZV2OUurvWqAvx1EFtf88BPo54ICgbRe
         y8m0A6nIb33RTKzmib100m5GFTwkWv7gt9INSBsWM0l0mk9CvfMTrwv/vuE6FE5lax/d
         ghTQ==
X-Gm-Message-State: AOAM530IYOhtoa5R4Pl8UW76fo9baxOXdHEL+v44Ud2kbsSsSEHsvtrU
        HrUdnyAK/bj2LftpcMdc8tjkAZiU+18=
X-Google-Smtp-Source: ABdhPJx7EmGOyqZ+TRY0bLcBzYzuLtj1pEQWUA6B5lw463ss6txDI9m4rk5DpLz+tPTspy4xGEmn9Q==
X-Received: by 2002:a17:90b:4c4f:: with SMTP id np15mr10314248pjb.18.1633059311904;
        Thu, 30 Sep 2021 20:35:11 -0700 (PDT)
Received: from localhost ([2601:647:5b00:6f70:be34:681b:b1e9:776f])
        by smtp.gmail.com with ESMTPSA id b2sm4569071pfr.58.2021.09.30.20.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 20:35:11 -0700 (PDT)
Date:   Thu, 30 Sep 2021 20:35:10 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     "Wu, Hao" <hao.wu@intel.com>
Cc:     "Xu, Yilun" <yilun.xu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Moritz Fischer <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "moritzf@google.com" <moritzf@google.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: Add Hao and Yilun as maintainers
Message-ID: <YVaB7m9SrGyI05zd@epycbox.lan>
References: <20210928150227.22275-1-mdf@kernel.org>
 <YVM0p3xrck0zriHd@kroah.com>
 <20210929004235.GC6179@yilunxu-OptiPlex-7050>
 <DM6PR11MB38198AC7508C50D208281A0685A99@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB38198AC7508C50D208281A0685A99@DM6PR11MB3819.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Sep 29, 2021 at 01:04:54AM +0000, Wu, Hao wrote:
> > On Tue, Sep 28, 2021 at 05:28:39PM +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Sep 28, 2021 at 08:02:25AM -0700, Moritz Fischer wrote:
> > > > Hao and Yilun have agreed to help out with maintenance.
> > > > Both have been active in the Linux FPGA community for a long time
> > > > and we need backups for vacation and load-balancing.
> > > >
> > > > Cc: Xu Yilun <yilun.xu@intel.com>
> > > > Cc: Wu Hao <hao.wu@intel.com>
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >
> > > I need an ack from the two new people here in order to take this :)
> > 
> > Acked-by: Xu Yilun <yilun.xu@intel.com>
> 
> Acked-by: Wu Hao <hao.wu@intel.com>
> 
> Thanks
> Hao
> 
> > 
> > Thanks,
> > Yilun
> > 
> > >
> > > thanks,
> > >
> > > greg k-h

Applied to for-next,

Moritz
