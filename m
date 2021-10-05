Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D2D42307B
	for <lists+linux-fpga@lfdr.de>; Tue,  5 Oct 2021 21:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbhJETEo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 5 Oct 2021 15:04:44 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:47070 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhJETEo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 5 Oct 2021 15:04:44 -0400
Received: by mail-pj1-f44.google.com with SMTP id pi19-20020a17090b1e5300b0019fdd3557d3so369324pjb.5
        for <linux-fpga@vger.kernel.org>; Tue, 05 Oct 2021 12:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9KHJsjTCsUmkgs+OZ6FJgtqcboXlbudoqmETEmRf/Lw=;
        b=y3v7+07Z9cBms4czPD+ULmyAjKY2ZnhCF1vDSWyqnPD4yK0dmuOT3UquPe5D3BoGTL
         Wup5wTLzYZgXcJOjyzttOXYdc5WIsmmRe5iQbdJ7Jg4g4DuZV8+R020srLqWEnIoM6l6
         IibFwauG3wIPybmS7DpZgvLhRmsw8TIzRo75EYXGeOdRvA24n4oVGCCcky6GUpDnYTml
         ht7ndpdfpdPeAggc8vxp7eD5jnmW7BD2mfRm34S9J3F7/LQP2r0XBf6LmtfI6FkG6Rm3
         e0v+5k6tm1dtJbSvn6WDssTGrge6mwE+48DMeF0F9PoSBdpTRxjC3Oxv6yk8IgI7G5Lw
         SmUg==
X-Gm-Message-State: AOAM533mUMU5cq1KUpZpz4nE2PVqnCkTR/rfjV7MNlL6wktKMH1ZkTgK
        CMZL1vH1iq3D7FEv/AWOpsUUQIuBvDcT2Q==
X-Google-Smtp-Source: ABdhPJzw1eD1nkgkvdfhIxIbaJovFV4/d9qlouXdx0+oFoUuoAzv4N6VO1MNanA+yo6Ww1kp//QSig==
X-Received: by 2002:a17:90a:4618:: with SMTP id w24mr5829284pjg.142.1633460573182;
        Tue, 05 Oct 2021 12:02:53 -0700 (PDT)
Received: from localhost ([2601:647:5b00:6f70:be34:681b:b1e9:776f])
        by smtp.gmail.com with ESMTPSA id l18sm19061717pfu.202.2021.10.05.12.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 12:02:52 -0700 (PDT)
Date:   Tue, 5 Oct 2021 12:02:51 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, yilun.xu@intel.com,
        hao.wu@intel.com, linux-fpga@vger.kernel.org, moritzf@google.com
Subject: Re: [GIT PULL] FPGA Manager changes for 5.16-rc1
Message-ID: <YVyhWw9et/5NEggO@epycbox.lan>
References: <YVyZJAOnAphoe/Vh@epycbox.lan>
 <YVygXlJxzJaXUANu@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVygXlJxzJaXUANu@kroah.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Oct 05, 2021 at 08:58:38PM +0200, Greg KH wrote:
> On Tue, Oct 05, 2021 at 11:27:48AM -0700, Moritz Fischer wrote:
> > The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
> > 
> >   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga tags/fpga-maintainer-update
> > 
> > for you to fetch changes up to 57b44817a8d63e75394bc21849f585ded53de8bb:
> > 
> >   MAINTAINERS: Drop outdated FPGA Manager website (2021-10-02 09:07:09 -0700)
> > 
> > ----------------------------------------------------------------
> > FPGA Manager changes for 5.16
> > 
> > The first patch adds Hao and Yilun as additional maintainers
> > for the FPGA Manager subsystem.
> > 
> > The second patch removes a now stale reference to a product specific
> > website that no longer reflects the FPGA Manager subsystem.
> > 
> > All patches have been reviewed on the mailing list, and have been in the
> > last few linux-next releases (as part of my for-next branch) without issues.
> > 
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > 
> > ----------------------------------------------------------------
> > Moritz Fischer (2):
> >       MAINTAINERS: Add Hao and Yilun as maintainers
> >       MAINTAINERS: Drop outdated FPGA Manager website
> 
> These are trivial, shouldn't we work to get these into 5.15-final?  I
> can gladly take them into my branch for that if you don't mind.

All the same to me :) I figured they're not fixes, so that's why for
next release.

Thanks,
Moritz
