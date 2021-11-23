Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D226459D38
	for <lists+linux-fpga@lfdr.de>; Tue, 23 Nov 2021 08:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbhKWH63 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 23 Nov 2021 02:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbhKWH62 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 23 Nov 2021 02:58:28 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADA3C061574;
        Mon, 22 Nov 2021 23:55:20 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id o4so18612016pfp.13;
        Mon, 22 Nov 2021 23:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=W1Z+R1vT9EnJVhFMcnD/LDI/JomT1Ev/JwgD6/pNlJc=;
        b=hi8DPjlIANuWf12HwEhHunu+oqi/8CqBOortH8fy8gExhNNADkH6qxQf3/2HPK9QVA
         klcLt8lhzwUyuRr62NwdRodZVn92Fdts9Yb2uYQ9uaxn4H+m2J4WYb5iAL9DHrX2hq24
         nTEp05HRZePJs9Mwl5tT2w5xQV3W/+SKOT3aGwyx/rfZJ2lgJ+QEDTvp0tiri5fQ7UK4
         mwm854NdHgO1sJIW6GY6fWH33c7Ny6QEywHDmY+hi6MZ/AC4+q8OnGnzUOQ5rc+H+XCs
         RhtPtThCxqFv7y+4Uf8+wyNvi285ka3kt7NG1BXfejmR9e9nP2OU2ek6ljL3W6e0MPYn
         o8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=W1Z+R1vT9EnJVhFMcnD/LDI/JomT1Ev/JwgD6/pNlJc=;
        b=F6UtJ1OfvN6vt3TTiPg2FKIYe16gq9MxWa1Z6xGG1JSuNh+4OUIGqbRtLq5zjq2/cK
         rVHeyRHegn8urApOWa/2MtcfNkU5j59iEXPgWgkK8vY1rFaF/1b32nz9Vpfu4kN3iE5G
         OoRFSXVxN+TQmK5tu+xI+fYJuelFuQoDJxL9hNLOl5vEWYXxpjA3VvGd4HQd3rrRQ1Ig
         2e+tetqk22Tg7F99NeBR/S+qmz8D248bJJwieh1pFKiRHkRuk2cVJkNLf14tb6YWgN9s
         MHGEpemvV8Knmnpax8ve41mtZL/3nYOqQ1QuOYxV1/z64+0COkdGJASMKaq79dGA6KGc
         nC0A==
X-Gm-Message-State: AOAM533/UlTg/0gUk3oWHCrNEA3DLIXxvs3Glml5laXQ+DAqF+jRfPp7
        /wxVqq1uPE6FJumGTt/OvekVUVJd/a4=
X-Google-Smtp-Source: ABdhPJwhkPpeTc50607ImFjo7wLWfv7MhJT63Sbm2uXW8O8eBBkR42rHJiMiwF2CayBodm7D5gdd+w==
X-Received: by 2002:a62:e907:0:b0:4a0:3a71:9712 with SMTP id j7-20020a62e907000000b004a03a719712mr3380322pfh.73.1637654119936;
        Mon, 22 Nov 2021 23:55:19 -0800 (PST)
Received: from [166.111.139.123] ([166.111.139.123])
        by smtp.gmail.com with ESMTPSA id q18sm6977879pfn.83.2021.11.22.23.55.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 23:55:19 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] fpga: dfl: possible ABBA deadlock in
 dfl_fpga_cdev_assign_port() and fme_pr()
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <9460c1ba-addd-9757-fe55-ceeeae596ac1@gmail.com>
Date:   Tue, 23 Nov 2021 15:55:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hello,

My static analysis tool reports a possible ABBA deadlock in the dfl 
driver in Linux 5.10:

dfl_fpga_cdev_assign_port()
   mutex_lock(&cdev->lock); --> Line 1067 (Lock A)
   mutex_lock(&pdata->lock); --> Line 1624 (Lock B)

fme_pr()
   mutex_lock(&pdata->lock); --> Line 126 (Lock B)
   fpga_region_program_fpga()
     fpga_bridges_enable()
       fpga_bridge_enable()
         fme_bridge_enable_set() --> function pointer via 
"bridge->br_ops->enable_set()"
           dfl_fpga_cdev_find_port()
             mutex_lock(&cdev->lock); --> Line 499 (LockA)

When dfl_fpga_cdev_assign_port() and fme_pr() are concurrently executed, 
the deadlock can occur.

I am not quite sure whether this possible deadlock is real and how to 
fix it if it is real.
Any feedback would be appreciated, thanks

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>


Best wishes,
Jia-Ju Bai
