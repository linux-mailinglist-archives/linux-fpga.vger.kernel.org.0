Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993073A1838
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 16:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238673AbhFIO6Y (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 10:58:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238655AbhFIO6V (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Jun 2021 10:58:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5748D611CC;
        Wed,  9 Jun 2021 14:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623250586;
        bh=hi9Zm13bY2EHbOWMSwsB4PGcBRZAE7GPxLYIyvX414w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NWjm+MQ0XmDsOaP1Cz6o2nzLqLZWj/aDsUYxDy0EGKaH2/U4QW3jwZCi7+I7cedWB
         on03nvojM4Mp4FWWnSLMIyUhEyKb6lI9pZiiCyRTorZ2EB5sJvld5ZmgdCeH9pVC+o
         hqjUgLbUbyh6Q/EA53rQRVmy314YU2NzQQe42Wu4=
Date:   Wed, 9 Jun 2021 16:56:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     trix@redhat.com
Cc:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com,
        nava.manne@xilinx.com, dinguyen@kernel.org,
        krzysztof.kozlowski@canonical.com, yilun.xu@intel.com,
        arnd@arndb.de, fpacheco@redhat.com, richard.gong@intel.com,
        luca@lucaceresoli.net, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/4] fpga: altera: reorganize to subdir layout
Message-ID: <YMDWmDGj55vReCX2@kroah.com>
References: <20210609142208.3085451-1-trix@redhat.com>
 <20210609142208.3085451-5-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609142208.3085451-5-trix@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jun 09, 2021 at 07:22:07AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Create a altera/ subdir
> Move altera-* and soc* ts73xx* files to it.
> Add a Kconfig and Makefile

Again no SPDX line?
