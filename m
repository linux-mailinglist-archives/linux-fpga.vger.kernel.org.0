Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9AA423075
	for <lists+linux-fpga@lfdr.de>; Tue,  5 Oct 2021 20:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbhJETAb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 5 Oct 2021 15:00:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhJETAb (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 5 Oct 2021 15:00:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46C916128A;
        Tue,  5 Oct 2021 18:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633460320;
        bh=0BuZAEhbOkw89bJ6BxT6SKr0kfz20xnQKr8SdWvbdmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p92PsoW37nFZ96pZfMKuQ9SdtcvC4yRChuFI0iz9el8s4jQtzwZVnNUKDplYhgKBT
         zcyL1BsBABJfRQvVanMng86VrZVMK0wQgBIqpdj9D506FnHkXO9nFsqlTVI5erCD6K
         74VsIWdIPr3Nigoq43104pxH/e9ZMVy8SpUwBWEc=
Date:   Tue, 5 Oct 2021 20:58:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     yilun.xu@intel.com, hao.wu@intel.com, linux-fpga@vger.kernel.org,
        moritzf@google.com
Subject: Re: [GIT PULL] FPGA Manager changes for 5.16-rc1
Message-ID: <YVygXlJxzJaXUANu@kroah.com>
References: <YVyZJAOnAphoe/Vh@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVyZJAOnAphoe/Vh@epycbox.lan>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Oct 05, 2021 at 11:27:48AM -0700, Moritz Fischer wrote:
> The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
> 
>   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga tags/fpga-maintainer-update
> 
> for you to fetch changes up to 57b44817a8d63e75394bc21849f585ded53de8bb:
> 
>   MAINTAINERS: Drop outdated FPGA Manager website (2021-10-02 09:07:09 -0700)
> 
> ----------------------------------------------------------------
> FPGA Manager changes for 5.16
> 
> The first patch adds Hao and Yilun as additional maintainers
> for the FPGA Manager subsystem.
> 
> The second patch removes a now stale reference to a product specific
> website that no longer reflects the FPGA Manager subsystem.
> 
> All patches have been reviewed on the mailing list, and have been in the
> last few linux-next releases (as part of my for-next branch) without issues.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> 
> ----------------------------------------------------------------
> Moritz Fischer (2):
>       MAINTAINERS: Add Hao and Yilun as maintainers
>       MAINTAINERS: Drop outdated FPGA Manager website

These are trivial, shouldn't we work to get these into 5.15-final?  I
can gladly take them into my branch for that if you don't mind.

thanks,

greg k-h
