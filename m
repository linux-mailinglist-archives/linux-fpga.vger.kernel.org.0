Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A078440C140
	for <lists+linux-fpga@lfdr.de>; Wed, 15 Sep 2021 10:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbhIOIK2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 15 Sep 2021 04:10:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236745AbhIOIK1 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 15 Sep 2021 04:10:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D81F261185;
        Wed, 15 Sep 2021 08:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631693349;
        bh=LgPwPTPVRDJc//j7F9EqNnIrHrHIv2fVzeu574yeFaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cGW9qTPWZx5KzpdYHBhO7q2Dl0ZWJ3TX2ZdQCQ8tsg7EUJd3OJ+/x/q/c+PDQcYDP
         5OWQxex0z+g6OXRETlSLDjl+VGLZXTR/otJC3bZ9R7a/Qu31IUP+RLsaHcCCA+qyGm
         d2c1RKxF0KW9BiKQ0kBWg4rttcLRwak+e5RFsXDc=
Date:   Tue, 14 Sep 2021 20:58:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     trix@redhat.com
Cc:     mdf@kernel.org, hao.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Tom Rix as fpga maintainer
Message-ID: <YUDw0gvgdijpytfU@kroah.com>
References: <20210914182333.3903389-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914182333.3903389-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

[note, you got the maintainer's email address wrong on your cc: line
 I fixed it up...]

On Tue, Sep 14, 2021 at 11:23:33AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> I am the maintainer of the fpga/ subsystem for both the kernel and
> userspace for Red Hat.  I have been an active reviewer and contributor
> on for public fpga/ subsystem for the last year.  I would like to
> help out more.
> 
> Since I am paid to do this work, change the status to Supported.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 04fa4edf100b83..0443d7ab826659 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7353,9 +7353,9 @@ F:	include/uapi/linux/fpga-dfl.h
>  
>  FPGA MANAGER FRAMEWORK
>  M:	Moritz Fischer <mdf@kernel.org>
> -R:	Tom Rix <trix@redhat.com>
> +M:	Tom Rix <trix@redhat.com>
>  L:	linux-fpga@vger.kernel.org
> -S:	Maintained
> +S:	Supported
>  W:	http://www.rocketboards.org
>  Q:	http://patchwork.kernel.org/project/linux-fpga/list/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git
> -- 
> 2.26.3
> 

Traditionally existing maintainers are the ones that add new
maintainers, it's not something that you just submit a patch for hoping
it will be accepted.

What has changed since the last time you asked to do this?

thanks,

greg k-h
