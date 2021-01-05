Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06D82EA13B
	for <lists+linux-fpga@lfdr.de>; Tue,  5 Jan 2021 01:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbhAEADA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 4 Jan 2021 19:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbhAEADA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 4 Jan 2021 19:03:00 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDF0C061793
        for <linux-fpga@vger.kernel.org>; Mon,  4 Jan 2021 16:02:19 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id o6so26616048iob.10
        for <linux-fpga@vger.kernel.org>; Mon, 04 Jan 2021 16:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=byixiRUYdYpYRco79RhgU3hXrVt1Me0pPkcjD+7vZYc=;
        b=WCKWH0Hg4xDl3lOVfhVXH5GfcAFGCV+bSqWU/OZJtQfwtg9FQBUox+elrFzgR/VWJq
         LJjhhnGVvlbO2WvmAkjJJ59Xf0DueywqooTXrZiXVju/gFcedehvrPuS00mCtXwSwXvr
         UkIcPhQvRos8/A/jwMcFb1BrLHhs3hAM5LgtdCIb0pQtcTYSu+fECpFS1rN+eL5D22wf
         2DHTfdfrPmiqqIx5vp/8wQbpsK5/4QPvwSq22d2yBMacsSSk49UIqRsZJDmot1F3fmp+
         p3TLFELnhA3rLp6ZwtqQnunb8gFIachfMtZObCz6ljU6bLLuUNLpVwHAqoCB+snwANUE
         /qzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=byixiRUYdYpYRco79RhgU3hXrVt1Me0pPkcjD+7vZYc=;
        b=Tz+OCX/ccVLThQrqnMjP+qFwoyWDL0OuBm0qV8q3rIsveNYnCF19RayXOFtL0wULwz
         Rg6L9r39KWRiJsQERPeh/nbS3+x8T1AUcgLbKT38qOIyRtkJzDoh4Vf0cpFlpVyoXmUB
         vFIIazxTbz2uAo8vREEYoYxj3bYGC3Ng/uN8ZYKNCQ1RB/02eX8dUjiCwx+uNNADLL5T
         N6DcIah0bThFBoouJ3xq4Tr6H+hFiMClYvhKvu1DJ/5rOz00maYezrLLxCqQTVhSzqdz
         4yAn2uWZNAPqqhKFGuj4LJECN87FJjE3Ev25GqjlZM5iM/9zzl3jk4Llwk3YCcb5CFVH
         PhYg==
X-Gm-Message-State: AOAM53206tBCAd8UT52sijp/3uk0T04zHLn4eYMLQtawTxz8R4aDcKo5
        AQMTvVvmgsczAIG4iDbtJJkiSfyqVLuLRjyOc7Qpac7cGm4=
X-Google-Smtp-Source: ABdhPJw2l+/CEiC/72hViJpygcxcoH9dxGeob2hZ/gG6cQlKuFzwLULAUjs/N8rELgLTTy2kYNp+e7nq+G2AinG/RpQ=
X-Received: by 2002:a6b:5018:: with SMTP id e24mr60558882iob.184.1609804939024;
 Mon, 04 Jan 2021 16:02:19 -0800 (PST)
MIME-Version: 1.0
References: <CAP14NRT3AN0+g=TsRRQ2vm+q+rT2zvC-rZmbeDb-8wagepiR7g@mail.gmail.com>
In-Reply-To: <CAP14NRT3AN0+g=TsRRQ2vm+q+rT2zvC-rZmbeDb-8wagepiR7g@mail.gmail.com>
From:   Chris Dot <chrisdotdot@gmail.com>
Date:   Tue, 5 Jan 2021 00:02:07 +0000
Message-ID: <CAP14NRQt5bZTFp_6o1kji=JqLLyS1=ANZp=Y5EL-E4_C-oU1LA@mail.gmail.com>
Subject: Stratix 10 CVP - how to write an image from userspace?
To:     linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi, I have a Stratix 10 PCIe FPGA card and I want to program it over CVP.

How do I do that? Would I write (dd?) to some sysfs node, use ioctls?
Any help appreciated.

Below is my workspace. This is kernel 5.4.

root@ubuntu20x:/sys/class/fpga_manager/fpga0# dmesg | grep -i cvp
[    3.693994] fpga_manager fpga0: Altera CvP FPGA Manager
@0000:02:00.0 registered
root@ubuntu20x:/sys/class/fpga_manager/fpga0# ls
device  name  power  state  status  subsystem  uevent
root@ubuntu20x:/sys/class/fpga_manager/fpga0# ls device
aer_dev_correctable   class                     d3cold_allowed
enable         local_cpulist   msi_bus    reset         subsystem
aer_dev_fatal         config                    device
firmware_node  local_cpus      numa_node  resource
subsystem_device
aer_dev_nonfatal      consistent_dma_mask_bits  dma_mask_bits
fpga_manager   max_link_speed  power      resource0
subsystem_vendor
ari_enabled           current_link_speed        driver           irq
         max_link_width  remove     resource0_wc  uevent
broken_parity_status  current_link_width        driver_override  link
         modalias        rescan     revision      vendor

Thanks, Chris
