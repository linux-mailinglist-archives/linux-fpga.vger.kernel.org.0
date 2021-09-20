Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051F9410FD3
	for <lists+linux-fpga@lfdr.de>; Mon, 20 Sep 2021 09:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbhITHH0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 20 Sep 2021 03:07:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233878AbhITHHX (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 20 Sep 2021 03:07:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1291060FF2;
        Mon, 20 Sep 2021 07:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632121557;
        bh=N8Vg4sGZs8t4QQ13p0cuYWVZLb5u3SF4grFx208hcbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2Sp6jo4/mwQOhp1o8E5QnHXBrv2AKgwK6TZ9dgxFIXOVOMZSYI+9cbDz1RKz1jA9h
         g7SdpHN9g+8/Udn1WB3gZk1ioHT0SFXao5rztTsOoSexDcPEw2xRjHxnaRaOZpVVmU
         L14b6p7L7yCbEaowXWaNWmQkr6DL1jUJxOcBKuEM=
Date:   Mon, 20 Sep 2021 09:05:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com
Subject: Re: [GIT PULL] FPGA Manager fixes for 5.15
Message-ID: <YUgyy9MnLNMznSMn@kroah.com>
References: <YUfAl+ngbh3GBFHU@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUfAl+ngbh3GBFHU@epycbox.lan>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Sep 19, 2021 at 03:58:31PM -0700, Moritz Fischer wrote:
> The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
> 
>   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga tags/fpga-fixes-5.15

Pulled and pushed out, thanks.

greg k-h
