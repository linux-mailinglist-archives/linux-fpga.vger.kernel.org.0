Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6C43DD2E9
	for <lists+linux-fpga@lfdr.de>; Mon,  2 Aug 2021 11:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbhHBJ0O (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 2 Aug 2021 05:26:14 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:53989 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbhHBJ0O (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 2 Aug 2021 05:26:14 -0400
Received: by mail-wm1-f41.google.com with SMTP id k4so9978201wms.3
        for <linux-fpga@vger.kernel.org>; Mon, 02 Aug 2021 02:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=zqnW49mX+sIMvtTAeODHlUIrA8VyirqtHIId3S1dkTo=;
        b=GuifTEGdtfrY7cYZUqPTHnvY/UJnQcXscZfHS8RNtgOk/4HhwwrDXyMlLYrgG7PoEi
         KPYv8koVLBfO0mr4GedRSv+TYn3VXqHMwL56vIfntLfkgBGlLHIQgLXoYbXeD0eEPHkN
         V8E7uerH4jtn54cCqShT5u9uIGSjaiUqy9/i5QM56Ir1j5rp3JzZlE+WnBAZapC6wm3r
         CHIhaSx+f7gEfoYHpEUtl/XNTlYM+fHPR1RkfJngg6lZl2He+m6LfjowfiNH+eXLGQFd
         gqaGuzy+cFULvaUQlGYztnmHHtbODCQ3hCOHMI3QwGQsGb2VJycc2JOh5UFLiQVrL6de
         gZ2w==
X-Gm-Message-State: AOAM532ca/F1FnQNgOZZoB0/7Q6A+1NhLpmK6/IMq+CgFqa8UCWUfkUW
        S3jfC5VFH1q3XYOevP4SkRg=
X-Google-Smtp-Source: ABdhPJyJVh7t1fGldUro8RNRPO5Rv1KieJoB7JSIdlI1dHo9Uv3e2SwgJ9OP/XDdbg5bpFqNJFmFQw==
X-Received: by 2002:a05:600c:354e:: with SMTP id i14mr15589712wmq.96.1627896364375;
        Mon, 02 Aug 2021 02:26:04 -0700 (PDT)
Received: from localhost ([149.172.45.165])
        by smtp.gmail.com with ESMTPSA id t16sm815328wmi.13.2021.08.02.02.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 02:26:04 -0700 (PDT)
Date:   Mon, 2 Aug 2021 02:26:03 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com
Subject: [GIT PULL] FPGA Manager fix for 5.14
Message-ID: <YQe6K+ksMWkwhDpF@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit ff1176468d368232b684f75e82563369208bc371:

  Linux 5.14-rc3 (2021-07-25 15:35:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-fixes-for-5.14

for you to fetch changes up to ec6446d5304b3c3dd692a1e244df7e40bbb5af36:

  fpga: dfl: fme: Fix cpu hotplug issue in performance reporting (2021-07-27 11:05:16 -0700)

----------------------------------------------------------------
FPGA Manager fix for 5.14

Kajol's fix adds a missing pmu_migrate_context() call which presents a
problem if the CPU collecting FME PMU data is taken offline.

All patches have been reviewed on the mailing list, and have been in the
last few linux-next releases (as part of my fixes branch) without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Kajol Jain (1):
      fpga: dfl: fme: Fix cpu hotplug issue in performance reporting

 drivers/fpga/dfl-fme-perf.c | 2 ++
 1 file changed, 2 insertions(+)
