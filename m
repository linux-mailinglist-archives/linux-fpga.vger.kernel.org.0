Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAA64A0B70
	for <lists+linux-fpga@lfdr.de>; Wed, 28 Aug 2019 22:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfH1U2j (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 28 Aug 2019 16:28:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfH1U2j (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 28 Aug 2019 16:28:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2212420856;
        Wed, 28 Aug 2019 20:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567024118;
        bh=YIS33MWkLBlADPV3tBpgDDEjVwBpzHs86mbbmcZXzJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m3eGL5Yn1wqbBwQ7d/RetkccILldpkPiLo4ZINBjA+8b3BBZthh074rMRU+m/oUnQ
         g0a3snV87f9nPDzlqXgZ55BmjfAsZWkvQ5zhLVJXew9qNDTQOrzO6y/76OuBmhLuoq
         nPCCrQxj4v1jT92g1kN7gvMEOoaQXyyhMidrN9gg=
Date:   Wed, 28 Aug 2019 22:28:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [GIT PULL] FPGA Manager (late) change for 5.3-rc6
Message-ID: <20190828202836.GA25916@kroah.com>
References: <20190819004744.GA20155@archbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819004744.GA20155@archbox>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Aug 18, 2019 at 05:47:44PM -0700, Moritz Fischer wrote:
> The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:
> 
>   Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git/ tags/fpga-fixes-for-5.3

Pulled and pushed out,t hanks.

greg k-h
