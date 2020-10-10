Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C683D289ED0
	for <lists+linux-fpga@lfdr.de>; Sat, 10 Oct 2020 09:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgJJHEj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 10 Oct 2020 03:04:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728667AbgJJHD6 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 10 Oct 2020 03:03:58 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9A3E207CD;
        Sat, 10 Oct 2020 07:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602313436;
        bh=F0F1LNuYml8C7KaYrbieRMB8KjT0b0KlbGLcN90ywNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eq64n3c6/mcINekdYRdy0LlhY+O91416Mz+Nbeyj0rJtgnuUPmkgoYyiHuy1LrniM
         pzI9/y8VgeYuagAs1cfG+gN7zwwuU5sEoThf0HokKCUbcADQCcOKi0ne/mT4vIChhP
         l4OpEG+EREIvpzOnWAUinB4ospIHYaB2LkYJ2qhQ=
Date:   Sat, 10 Oct 2020 09:03:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Xu Yilun <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com
Subject: Re: [PATCH v3 1/5] fpga: dfl: rename the bus type "dfl" to "fpga-dfl"
Message-ID: <20201010070352.GA133012@kroah.com>
References: <20200927055108.GA701198@kroah.com>
 <20200927073754.GB16433@yilunxu-OptiPlex-7050>
 <20200927075401.GA748141@kroah.com>
 <20200927083647.GC16433@yilunxu-OptiPlex-7050>
 <20200929012323.GD16433@yilunxu-OptiPlex-7050>
 <20200929041900.GA113620@archbook>
 <20201009062059.GB24324@yilunxu-OptiPlex-7050>
 <20201009064118.GA655664@kroah.com>
 <20201009073424.GA15377@yilunxu-OptiPlex-7050>
 <20201009212839.GB2531@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009212839.GB2531@epycbox.lan>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Oct 09, 2020 at 02:28:39PM -0700, Moritz Fischer wrote:
> We're pretty late in the cycle, so this is gonna wait till the next cycle most likely.

My trees are closed for new stuff for 5.10-rc1, so yes, it has to be for
the next round.

I'll try to get to the "wall of text" next week...

greg k-h
