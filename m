Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA4B41FCF9
	for <lists+linux-fpga@lfdr.de>; Sat,  2 Oct 2021 18:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhJBQLC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 2 Oct 2021 12:11:02 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:35835 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhJBQLA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 2 Oct 2021 12:11:00 -0400
Received: by mail-pf1-f171.google.com with SMTP id c29so333807pfp.2
        for <linux-fpga@vger.kernel.org>; Sat, 02 Oct 2021 09:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dO6gGfHi6+mLexPKMK8ad8PKeLcmXKfA66cWxvK6g/o=;
        b=dvuYfL+LH2Ucs04X3aI+afogGY2NtWTeGmU6IYkdrBf9gA+n84/5Uly8iDtA8VcqMp
         WuJLPErdSwMNE5iiXj0yTuUHc3qOM7BhTqt5p9EI3jDD6JBTx8m+QaneZ32jnf82lv+g
         oXvEl8brWUfDK+CWBhZaPSZhj+Tav0TcnFgjJmnuaAEovcD0CnM0z+ReCjr1QLzpztNN
         vVLzUYQHH3CN9UFbVH/wepx08hHRTSjSYZZObWK+QYRrgt4Q8TFWx8ZMQZU8OXa+YWYi
         N/I/PjIZ8I/hGKzvDxMbt9vgaAH2xcOM5Y3kG7wObtWIocMb9RYPfjhAAKdkbzSVLdeP
         koNw==
X-Gm-Message-State: AOAM531FdAsNZZISQCHHdWfHUuvqEOlnr6+WeePnuomQ3MTA8LFNqKwq
        yDijLmDeaHdBEHTnKChJ2pU=
X-Google-Smtp-Source: ABdhPJw1PhdRhjZ1NgnmlegXKep+CI0b+cXf6B8f7Lly9gA4H6vk2hx86vt/WUv79NXzaBSYBAc5Xg==
X-Received: by 2002:a63:dc03:: with SMTP id s3mr3393463pgg.88.1633190954591;
        Sat, 02 Oct 2021 09:09:14 -0700 (PDT)
Received: from localhost ([2601:647:5b00:6f70:be34:681b:b1e9:776f])
        by smtp.gmail.com with ESMTPSA id y13sm8843539pjm.5.2021.10.02.09.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 09:09:13 -0700 (PDT)
Date:   Sat, 2 Oct 2021 09:09:11 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        moritzf@google.com, Wu Hao <hao.wu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] MAINTAINERS: Drop outdated FPGA Manager website
Message-ID: <YViEJzj6yL7mhdcj@epycbox.lan>
References: <20210928150227.22275-1-mdf@kernel.org>
 <20210928150227.22275-2-mdf@kernel.org>
 <20211002144957.GA53209@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211002144957.GA53209@yilunxu-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Oct 02, 2021 at 10:49:57PM +0800, Xu Yilun wrote:
> On Tue, Sep 28, 2021 at 08:02:26AM -0700, Moritz Fischer wrote:
> > The rocketboards website no longer really reflects a good landing
> > place for people interested in FPGA Manager.
> > 
> > Cc: Xu Yilun <yilun.xu@intel.com>
> > Cc: Wu Hao <hao.wu@intel.com>
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> >  MAINTAINERS | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2ec4c2a2458a..c4eaac287edb 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7342,7 +7342,6 @@ M:	Xu Yilun <yilun.xu@intel.com>
> >  R:	Tom Rix <trix@redhat.com>
> >  L:	linux-fpga@vger.kernel.org
> >  S:	Maintained
> > -W:	http://www.rocketboards.org
> 
> The website is mostly about SOCFPGA architecture, while the FPGA Manager
> is mainly about the generic image loading and enumeration framework. So
> I'm good to this change.
> 
> People could still find the website at ARM/SOCFPGA ARCHITECTURE, which is a
> better place for it.
> 
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> 
> Thanks,
> Yilun
> 
> >  Q:	http://patchwork.kernel.org/project/linux-fpga/list/
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git
> >  F:	Documentation/devicetree/bindings/fpga/
> > -- 
> > 2.33.0

Applied to for-next,

Thanks
