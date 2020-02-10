Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBDB7157FD7
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Feb 2020 17:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgBJQeH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Feb 2020 11:34:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:36948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727640AbgBJQeG (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 10 Feb 2020 11:34:06 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83BE42085B;
        Mon, 10 Feb 2020 16:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581352446;
        bh=M1hd3p9CfdbpxNt92LvggRQSIKAyGUl2mET37GiGwb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=USLhZXtzCssL6tE52ftuZWqw+kDdKDOY2DEkJ8Nq9CoKd2ivfCUakOsUtt6txO8ue
         z/snzuxStwbUXtXTNXQDA22n1aWldWd/aTI5bEfQWKXQZn6+wPpH5IjbU+zTfTDFbV
         TFmEGG5XJQHUIHMGzNL9LnpS2p2JjDueUGbgds+o=
Date:   Mon, 10 Feb 2020 16:34:01 +0000
From:   Will Deacon <will@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     mdf@kernel.org, mark.rutland@arm.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, atull@kernel.org, yilun.xu@intel.com,
        Luwei Kang <luwei.kang@intel.com>
Subject: Re: [PATCH v7 2/2] fpga: dfl: fme: add performance reporting support
Message-ID: <20200210163400.GA21900@willie-the-truck>
References: <1581306469-22629-1-git-send-email-hao.wu@intel.com>
 <1581306469-22629-3-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581306469-22629-3-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi,

On Mon, Feb 10, 2020 at 11:47:49AM +0800, Wu Hao wrote:
> This patch adds support for performance reporting private feature
> for FPGA Management Engine (FME). Now it supports several different
> performance counters, including 'basic', 'cache', 'fabric', 'vtd'
> and 'vtd_sip'. It allows user to use standard linux tools to access
> these performance counters.

I had a quick look at this, and it mostly looks alright to me. Just a few
high-level comments/questions:

  - I would still prefer for the PMU drivers to live under drivers/perf/

  - You should probably give the PMU a better name than "fme%d", for example
    "intel_fpga_dfl_fme%d".

  - CPU0 can be hotplugged off on non-x86 systems. How do you cope with
    that?

  - readq() will emit 2x32-bit reads on some architectures. What happens
    in this case?

Will
