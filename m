Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF62928A7D5
	for <lists+linux-fpga@lfdr.de>; Sun, 11 Oct 2020 16:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbgJKOpZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 11 Oct 2020 10:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388019AbgJKOpZ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 11 Oct 2020 10:45:25 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A080C2078B;
        Sun, 11 Oct 2020 14:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602427525;
        bh=vNCbxLl9Gr6BpMkpxMUmtZ4tHw70QAR6+ZwOOIXagz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a40xISPPyXLStVVrSfNh0f5nWONhK4KbfGT1Tbd2n/lCPhfScnA40Mr3/Qg8tYJEn
         h5PamBNgikRqAivH/5Qd1lcGDUZp52kreNWEjBqWCi3/tZZ2o0+x9i4Lt9Om2ag4tR
         d+TMNpC87FKLFWYr2Y2bBJ7B6WaRt+ZcVqVxfUYw=
Date:   Sun, 11 Oct 2020 16:45:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, krzk@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com
Subject: Re: [PATCH v9 4/6] fpga: dfl: move dfl bus related APIs to
 include/linux/fpga/dfl.h
Message-ID: <20201011144522.GB271501@kroah.com>
References: <1602313793-21421-1-git-send-email-yilun.xu@intel.com>
 <1602313793-21421-5-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602313793-21421-5-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Oct 10, 2020 at 03:09:51PM +0800, Xu Yilun wrote:
> Now the dfl drivers could be made as independent modules and put in
> different folders according to their functionalities. In order for
> scattered dfl device drivers to include dfl bus APIs, move the
> dfl bus APIs to a new header file in the public folder.
> 
> [mdf@kernel.org: Fixed up MAINTAINERS entry merge]
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> Acked-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
> v2: updated the MAINTAINERS under FPGA DFL DRIVERS
>     improve the comments
>     rename the dfl-bus.h to dfl.h
> v3: rebase the patch for previous changes
> v9: rebase the patch for bus name changes back to "dfl"
> ---
>  MAINTAINERS              |  1 +
>  drivers/fpga/dfl.c       |  1 +
>  drivers/fpga/dfl.h       | 72 ----------------------------------------
>  include/linux/fpga/dfl.h | 86 ++++++++++++++++++++++++++++++++++++++++++++++++

Why in the fpga directory?

thanks,

greg k-h
