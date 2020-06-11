Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEDB1F6E0B
	for <lists+linux-fpga@lfdr.de>; Thu, 11 Jun 2020 21:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgFKTiq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 11 Jun 2020 15:38:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20117 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726134AbgFKTin (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 11 Jun 2020 15:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591904321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=u8/OdraxV9Bf+mXB4Fs4dcRV8raf0sIOF0iql8UflHo=;
        b=HWDeTYASrTiC3wLsZtH4rDqqw0ZCIk2HXly2XKI69u1LDcWCzYMb7wp0y0OyiLPxkyCQhz
        6ZzJTqpJkW68lVn2hDcqjrXLjCMZLts2zkeb+nJGmCW3AQkAps0qEfZaHSOn/qsyjI+7Dw
        cBXp0boKGCAcPbajqzlynmbD8FN2gu8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-vFKYwiaiN6mczYQvfJgYIg-1; Thu, 11 Jun 2020 15:38:35 -0400
X-MC-Unique: vFKYwiaiN6mczYQvfJgYIg-1
Received: by mail-qk1-f199.google.com with SMTP id m29so6003951qkm.17
        for <linux-fpga@vger.kernel.org>; Thu, 11 Jun 2020 12:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u8/OdraxV9Bf+mXB4Fs4dcRV8raf0sIOF0iql8UflHo=;
        b=G31TVo07wYMoCMx1deR9Djg/5h7FGWqsH/VnIyFFYQtlLLwC8roCrojYfWdNy7EiaT
         cmeUW2Un4aZ/cnhoNkURxJqFYrfo2/dECW6xmm2sC8RCQzVhZd83GTfFB5BbODWOXMuF
         FZJEXJTeKywVU3uzTV2uHaGmz7sd7AflkzeOp4VM2l7JgDph4UxVsmm2wdYdttAd0wCg
         U1v3I2qi8whLO0EupGfNI5QHwnEzwywYl+7fGY9Q52nbpz+uyWN9Pvw/DHMxRVlvJlX8
         l66jZPfmfHsAGYxua7LjNqQfaT0mmeJFWdjxuMJRqk/WU6dzNwhTWGCAogx3J3e2NJBp
         nBsA==
X-Gm-Message-State: AOAM532rsUZ8Utii/VVR4yY28ns0tDsocALD9lVYW+aIyOLXgBnZA08z
        jvbSISY25vjNZNT06EKZk0dvVdg28hqGwcpZvaHxeSGITlA/2nFweLM6wNwbmMguuIfWWprBEeW
        rUIACXsN41ug/UhxRMdOk8w==
X-Received: by 2002:a37:9a4c:: with SMTP id c73mr10196336qke.450.1591904314732;
        Thu, 11 Jun 2020 12:38:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQtwswsTGgRQ9rrZiZRxCAHbWdA8cWacLl6m7dxpVA5zy7jW4IXrGz/yV8yRp3gYQa1DE2tg==
X-Received: by 2002:a37:9a4c:: with SMTP id c73mr10196317qke.450.1591904314480;
        Thu, 11 Jun 2020 12:38:34 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j22sm3020783qke.117.2020.06.11.12.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 12:38:33 -0700 (PDT)
From:   trix@redhat.com
To:     shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-fpga@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2 0/1]  selftests: fpga: dfl: A test for afu interrupt support
Date:   Thu, 11 Jun 2020 12:38:26 -0700
Message-Id: <20200611193827.8302-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

repo: linux-next
tag: next-20200611

Start applying selftests to drivers/fpga.

While testing out this upcoming change on linux-fpga
'Add interrupt support to FPGA DFL drivers'

I did not see any existing fpga tests.
So I added one.

Change from v1
Use ksft_* functions for reporting

Tom Rix (1):
  selftests: fpga: dfl: A test for afu interrupt support

 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/drivers/fpga/Makefile |  9 +++++
 .../testing/selftests/drivers/fpga/afu_intr.c | 33 +++++++++++++++++++
 tools/testing/selftests/drivers/fpga/config   |  1 +
 4 files changed, 44 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/fpga/Makefile
 create mode 100644 tools/testing/selftests/drivers/fpga/afu_intr.c
 create mode 100644 tools/testing/selftests/drivers/fpga/config

-- 
2.18.1

