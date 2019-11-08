Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E66B4F52F6
	for <lists+linux-fpga@lfdr.de>; Fri,  8 Nov 2019 18:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKHRvE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 8 Nov 2019 12:51:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:60936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbfKHRvE (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 8 Nov 2019 12:51:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AFFA218AE;
        Fri,  8 Nov 2019 17:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573235463;
        bh=xnQvemzN85bEcNkhB6+tB/8Y5fB3NArP2mLNmlAmrPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PF07cO0dEq0xEtfEUbqVwTtIUZFnLXRUTULfwVMx1e91csRyE0irnf4X4/Hs2aBIX
         65KWy97AHx0wVWfu5EOaVe7BIVABmLsQsj3kIRnVLP1IHIb57I2vmli5XJiNCun9Mk
         wUgDUGlfOdb8XiWbBOrY7tgtPP1A62wEs4OiX3yU=
Date:   Fri, 8 Nov 2019 18:50:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, hao.wu@intel.com, moritzf@google.com
Subject: Re: [GIT PULL] FPGA changes for 5.5
Message-ID: <20191108175053.GA1214838@kroah.com>
References: <20191108161808.GA398122@archbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108161808.GA398122@archbox>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Nov 08, 2019 at 08:19:30AM -0800, Moritz Fischer wrote:
> The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:
> 
>   Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-dfl-for-5.5

Pulled and pushed out, thanks.

greg k-h
