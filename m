Return-Path: <linux-fpga+bounces-560-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7779138CE
	for <lists+linux-fpga@lfdr.de>; Sun, 23 Jun 2024 09:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22EC31F2157C
	for <lists+linux-fpga@lfdr.de>; Sun, 23 Jun 2024 07:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED46374C6;
	Sun, 23 Jun 2024 07:40:47 +0000 (UTC)
X-Original-To: linux-fpga@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA76520317;
	Sun, 23 Jun 2024 07:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719128447; cv=none; b=mi8NiND9CQT9sd/0w6WBcOmbdmTeoyN6npLw/sOQhf57NJznekmfWXXEMQ6LDO4lDymte215A4kRNjM/yGIilvCqBvrNbP4pjoJ/0XM2e0B22pUHT+v2ETvpMU8ia26VelE7tl5rvUXFE6XgJUZ1YtIWDTDhw+JbfBhgw3ZbDag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719128447; c=relaxed/simple;
	bh=YGgrvC9wJ2y41CwGjbwtn8JQvu/KZOJCi7vR2+8GHCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jp+y+Hu0MUmGy1NFzKqz2Fui54td8NOxmgJeWi8QtDVBvIJkk9lSCrHYtU+rsdxnM3hGhhS1y1LUesysG550KTSIQSYUAB0qCxCf7dy2VWanbDI6dNGbuTcNg+WZZvAANyR7j2522m8HRt49mVD9aY9tRSNhCLgxH9nLj4z23O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowAD3_RFk0Xdm6Co7DA--.6009S2;
	Sun, 23 Jun 2024 15:40:30 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: hao.wu@intel.com,
	trix@redhat.com,
	mdf@kernel.org,
	yilun.xu@intel.com
Cc: linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH] fpga: dfl: fix potential memory leak in vfio_intx_enable()
Date: Sun, 23 Jun 2024 15:40:19 +0800
Message-Id: <20240623074019.2083481-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAD3_RFk0Xdm6Co7DA--.6009S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFy7urWruryUtF4DuF13twb_yoWxCrc_Kr
	4kXryxGF1DWFnI9w4ayw45Za92ya1j9Fs7WFn2qF9IqrykXr9rA34UuF1DJw4DZw15Wr17
	ZFyUtrW3A3Z7CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r106r1rM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
	Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUQZ23UUU
	UU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

We should free 'feature->irq_ctx[idx].name' to avoid 'name'
memory leak when request_irq() failed.

Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/fpga/dfl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 094ee97ea26c..c52ebece5aef 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1911,7 +1911,7 @@ static int do_set_irq_trigger(struct dfl_feature *feature, unsigned int idx,
 			  feature->irq_ctx[idx].name, trigger);
 	if (!ret) {
 		feature->irq_ctx[idx].trigger = trigger;
-		return ret;
+		goto free_name;
 	}
 
 	eventfd_ctx_put(trigger);
-- 
2.25.1


