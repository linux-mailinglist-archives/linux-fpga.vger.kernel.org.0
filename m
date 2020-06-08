Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A351F1960
	for <lists+linux-fpga@lfdr.de>; Mon,  8 Jun 2020 14:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbgFHMy7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 8 Jun 2020 08:54:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41953 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729578AbgFHMy4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 8 Jun 2020 08:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591620894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=jY3OPm4RpBTiGQk+tMR5hTIetdqJd5vfaxOWuwXTB3Y=;
        b=Q9/3cVksL1o/Rc/I+20bUrbAIahb2OKtDZQTSdW1sbaNM2qKcZsf0WGcsvgDE9Cubdz276
        ajnhEhcYD++gQ18M1aCOiO0WQChiFbRTF37xYJH4u2cC3scxVZZC/j8I11ZfFNh9kZH/Ek
        aiVDT1A7wROREPm5ySa9wMTqFNWOj8A=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-yB1puUTON1GOD3Z-cQ3zuA-1; Mon, 08 Jun 2020 08:54:53 -0400
X-MC-Unique: yB1puUTON1GOD3Z-cQ3zuA-1
Received: by mail-qv1-f72.google.com with SMTP id k35so13887460qva.18
        for <linux-fpga@vger.kernel.org>; Mon, 08 Jun 2020 05:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jY3OPm4RpBTiGQk+tMR5hTIetdqJd5vfaxOWuwXTB3Y=;
        b=J5ZnveAa+M5zNVTIGHPntpeBuuTJ7WPfJWavfqe+Ampq5ktwWoDawl+tdBv2wTSu6d
         kq/jtHRATy0ETuxeRGhwi5Dd+0cHwS3ACeRY2BfbWPr6TNnWaz6rZLkKEofw8O9lPfS9
         LhcefbFuVpCX3abgzRCFB4wAvzRn3OIzcooArxfdzWHngcQM2+Cdv0r6VM5qFNHdWUOe
         UWwn5TdJ7wYqGfk/W0VwQ24z3KV8aO2MLZDZJ705Ne3ATcz45w9xPbre3zGKjqNFRuHc
         9b0Y8HTf2Np2020WHfvt2dQdM+d7k3t9ztKk4KS0oaJno/PrAWPVSnHgI8h7x7YwnWU8
         apNg==
X-Gm-Message-State: AOAM5339+SlaO0AWIanNjt1DJWGSlevi19pnLRwG/2hRgQ4wHBL6dVtJ
        fW6m9ZDZmor6mubnf2PXWrqfWUh+u6Jqc0lqnlGixYZp7sAv+IbhMK6m0AD+E7aLay5dUCHjHpL
        ZdywXtliwmKLneoyg1fXOMg==
X-Received: by 2002:a05:6214:72a:: with SMTP id c10mr21411628qvz.189.1591620892879;
        Mon, 08 Jun 2020 05:54:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLX+kbWJfuOOXSXfzby71lXVvgp9fnIX3ZtAcmuGXq2m7+Kc0tu6+ZGRov6RdZsjVIs7Jo0A==
X-Received: by 2002:a05:6214:72a:: with SMTP id c10mr21411615qvz.189.1591620892683;
        Mon, 08 Jun 2020 05:54:52 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id y54sm7750628qtj.28.2020.06.08.05.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 05:54:52 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2 0/2] fpga: Fix dead store
Date:   Mon,  8 Jun 2020 05:54:44 -0700
Message-Id: <20200608125446.23311-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

repo: linux-next
tag: next-20200608

A couple of fixes for dead stores found by clang's sa tool scan-build

Main changes from v1:
Split single patch into two patch

Tom Rix (2):
  fpga: Fix dead store fpga-mgr.c
  fpga: Fix dead store in fpga-bridge.c

 drivers/fpga/fpga-bridge.c | 6 ++----
 drivers/fpga/fpga-mgr.c    | 4 +---
 2 files changed, 3 insertions(+), 7 deletions(-)

-- 
2.26.0

