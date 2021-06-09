Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3AED3A183A
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 16:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238644AbhFIO6i (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 10:58:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238616AbhFIO6f (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Jun 2021 10:58:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79A86611CC;
        Wed,  9 Jun 2021 14:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623250601;
        bh=QcXcoCHqRToiVYjGJQBeuWzSgQGC9WmgZbjg7vHhcf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1w8BXspqXRnYPh6n2ZfBZboVrc3s7W0W3QJrs/oQQID1Z4WpwuAll2UHLCmQYU7J6
         HN16/qu2APsuaqs28SpK15C2TmL1g8zjhlJjG+jvxJp34qwo0HLPsQoizs/VRtPcHt
         FwR7NUM+1LZWb4yqcVOyVboX0deQV5U9yc96o2b8=
Date:   Wed, 9 Jun 2021 16:56:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     trix@redhat.com
Cc:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com,
        nava.manne@xilinx.com, dinguyen@kernel.org,
        krzysztof.kozlowski@canonical.com, yilun.xu@intel.com,
        arnd@arndb.de, fpacheco@redhat.com, richard.gong@intel.com,
        luca@lucaceresoli.net, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/4] fpga: lattice: reorganize to subdir layout
Message-ID: <YMDWpgO0ejNfUEKJ@kroah.com>
References: <20210609142208.3085451-1-trix@redhat.com>
 <20210609142208.3085451-6-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609142208.3085451-6-trix@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jun 09, 2021 at 07:22:08AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Create a lattice/ subdir
> Move ice40* and machxo2* files to it.
> Add a Kconfig and Makefile
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

And again, no SPDX line :(
