Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154883DDF37
	for <lists+linux-fpga@lfdr.de>; Mon,  2 Aug 2021 20:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhHBSdX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 2 Aug 2021 14:33:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhHBSdX (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 2 Aug 2021 14:33:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DFB7610A2;
        Mon,  2 Aug 2021 18:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627929193;
        bh=4Ww/T3OBDnKPCprwQ26YNlWi6r/pJpoICtPUnu53YKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l+BNyYAzzbzhSOQT7LkYHtGbdVUzaW3mgIl673E5FV9l5taHn3Qqf2eMbWiBerlbL
         COOyWhSvb18u0fV2i+siE54FGzGmztspv7eRTcP58E9UcQ9eUQZ5LA7RhtxlxqTh1r
         LqSJoQzxhGGYTDnKmMfn64WTw3Ig6+8YxeR/u9hQ=
Date:   Mon, 2 Aug 2021 18:08:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com
Subject: Re: [GIT PULL] FPGA Manager fix for 5.14
Message-ID: <YQgYkkHIeVozd8Zc@kroah.com>
References: <YQe6K+ksMWkwhDpF@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQe6K+ksMWkwhDpF@archbook>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Aug 02, 2021 at 02:26:03AM -0700, Moritz Fischer wrote:
> The following changes since commit ff1176468d368232b684f75e82563369208bc371:
> 
>   Linux 5.14-rc3 (2021-07-25 15:35:14 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-fixes-for-5.14

Pulled and pushed out, thanks.

greg k-h
