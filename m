Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D33423008
	for <lists+linux-fpga@lfdr.de>; Tue,  5 Oct 2021 20:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhJEScR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 5 Oct 2021 14:32:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhJEScR (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 5 Oct 2021 14:32:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 343A76124C;
        Tue,  5 Oct 2021 18:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633458626;
        bh=IJi2vELn/rM5KHqQY9eHLFGzIcC+MTgN2m+FJ9Ig7oE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FMFuPPbJJtzUZGOdGzwbXr8QBpa490uxPTHUH4QRIBZlYjPynXpnGtRt/C4EyrP83
         FiTSuaCD0lVXltamNlcQ42z9ZifgmSxrxkwgJqCaa10CqHOs8oOPPJ+9L9ctWvBlDr
         a4gqxne1Y3mwXqlBzfWV9+Zgfp1eMhybBl1EVErA=
Date:   Tue, 5 Oct 2021 20:30:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, yilun.xu@intel.com, hao.wu@intel.com,
        moritzf@google.com
Subject: Re: [GIT PULL] FPGA Manager fix for 5.15-rc5
Message-ID: <YVyZwO2h2+d8Tyeh@kroah.com>
References: <YVyYBilF18kybSKL@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVyYBilF18kybSKL@epycbox.lan>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Oct 05, 2021 at 11:23:02AM -0700, Moritz Fischer wrote:
> The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:
> 
>   Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga tags/fpga-fixes-5.15-rc5

Pulled and pushed out, thanks.

greg k-h
